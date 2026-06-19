import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

// =======================
// GET ONE QUESTION
// =======================
export async function GET(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  try {
    const question = await prisma.question.findUnique({
      where: { id: Number(id) },
      include: {
        translations: true,
        options: {
          include: {
            translations: true,
          },
        },
      },
    });

    if (!question) {
      return NextResponse.json({ error: "NOT_FOUND" }, { status: 404 });
    }

    return NextResponse.json(question);
  } catch (error) {
    console.error("FETCH ERROR:", error);
    return NextResponse.json({ error: "FETCH_FAILED" }, { status: 500 });
  }
}

// =======================
// DELETE QUESTION (FIXED)
// =======================
export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  const qId = Number(id);

  try {
    // 1️⃣ delete option translations
    await prisma.optionTranslation.deleteMany({
      where: {
        option: {
          questionId: qId,
        },
      },
    });

    // 2️⃣ delete options
    await prisma.option.deleteMany({
      where: {
        questionId: qId,
      },
    });

    // 3️⃣ delete question translations
    await prisma.questionTranslation.deleteMany({
      where: {
        questionId: qId,
      },
    });

    // 4️⃣ delete question
    await prisma.question.delete({
      where: { id: qId },
    });

    return NextResponse.json({ message: "DELETED" });

  } catch (error) {
    console.error("DELETE ERROR:", error);

    return NextResponse.json(
      { error: "DELETE_FAILED" },
      { status: 500 }
    );
  }
}

// =======================
// UPDATE QUESTION (FULL FIX)
// =======================
export async function PUT(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;
  const qId = Number(id);

  try {
    const { image, translations, options } = await req.json();

    // 1️⃣ update main question
    await prisma.question.update({
      where: { id: qId },
      data: { image },
    });

    // 2️⃣ remove old translations
    await prisma.questionTranslation.deleteMany({
      where: { questionId: qId },
    });

    // 3️⃣ add new translations
    if (translations?.length) {
      await prisma.questionTranslation.createMany({
        data: translations.map((t: any) => ({
          language: t.language,
          text: t.text,
          questionId: qId,
        })),
      });
    }

    // 4️⃣ get old options
    const oldOptions = await prisma.option.findMany({
      where: { questionId: qId },
    });

   const oldOptionIds = (oldOptions || []).map((o: { id: number }) => o.id);

    // 5️⃣ delete option translations
    await prisma.optionTranslation.deleteMany({
      where: {
        optionId: { in: oldOptionIds },
      },
    });

    // 6️⃣ delete options
    await prisma.option.deleteMany({
      where: { questionId: qId },
    });

    // 7️⃣ recreate options
    if (options?.length) {
      for (const opt of options) {
        const createdOption = await prisma.option.create({
          data: {
            questionId: qId,
            isCorrect: opt.isCorrect,
          },
        });

        await prisma.optionTranslation.createMany({
          data: opt.translations.map((t: any) => ({
            language: t.language,
            text: t.text,
            optionId: createdOption.id,
          })),
        });
      }
    }

    return NextResponse.json({ message: "UPDATED" });

  } catch (error) {
    console.error("UPDATE ERROR:", error);

    return NextResponse.json(
      { error: "UPDATE_FAILED" },
      { status: 500 }
    );
  }
}