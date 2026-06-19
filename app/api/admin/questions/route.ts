import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

// =======================
// GET ALL QUESTIONS
// =======================
export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);

    const numberParam = searchParams.get("number");

    const whereCondition =
      numberParam && !isNaN(Number(numberParam))
        ? { number: Number(numberParam) }
        : undefined;

    const questions = await prisma.question.findMany({
      where: whereCondition,
      include: {
        translations: true,
        options: {
          include: {
            translations: true,
          },
        },
      },
      orderBy: { id: "desc" },
    });

    return NextResponse.json(questions);
  } catch (error) {
    console.error("FETCH_ERROR:", error);
    return NextResponse.json(
      { error: "FETCH_FAILED" },
      { status: 500 }
    );
  }
}// =======================
// CREATE QUESTION (SINGLE + BULK)
// =======================
export async function POST(req: Request) {
  try {
    const body = await req.json();

    // 🔥 get last number once
    const last = await prisma.question.findFirst({
      orderBy: { number: "desc" },
    });

    let nextNumber = last?.number ? last.number + 1 : 1;

    // =========================
    // 🔥 BULK INSERT
    // =========================
    if (Array.isArray(body)) {
      const createdQuestions = [];

      for (const q of body) {
        if (!q.translations || !q.options) continue;

        const question = await prisma.question.create({
          data: {
            type: q.type,
            image: q.image || null,
            number: nextNumber++,

            translations: {
              create: q.translations,
            },

            options: {
              create: q.options.map((opt: any) => ({
                isCorrect: opt.isCorrect,
                translations: {
                  create: opt.translations,
                },
              })),
            },
          },
          include: {
            translations: true,
            options: {
              include: {
                translations: true,
              },
            },
          },
        });

        createdQuestions.push(question);
      }

      return NextResponse.json(createdQuestions);
    }

    // =========================
    // 🔥 SINGLE INSERT
    // =========================
    const { type, image, translations, options } = body;

    const question = await prisma.question.create({
      data: {
        type,
        image: image || null,
        number: nextNumber,

        translations: {
          create: translations,
        },

        options: {
          create: options.map((opt: any) => ({
            isCorrect: opt.isCorrect,
            translations: {
              create: opt.translations,
            },
          })),
        },
      },
      include: {
        translations: true,
        options: {
          include: {
            translations: true,
          },
        },
      },
    });

    return NextResponse.json(question);
  } catch (error) {
    console.error("CREATE_ERROR:", error);
    return NextResponse.json(
      { error: "CREATE_FAILED" },
      { status: 500 }
    );
  }
}