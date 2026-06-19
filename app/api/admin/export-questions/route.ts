import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    const questions = await prisma.question.findMany({
      where: { deleted: false },
      include: {
        translations: true,
        options: {
          include: {
            translations: true,
          },
        },
      },
      orderBy: { number: "asc" },
    });

    const safeQuestions = questions.map((q: any) => ({
      id: q.id,
      number: q.number,
      image: q.image,
      translations: q.translations,
      options: q.options.map((o: any) => ({
        id: o.id,
        translations: o.translations,
      })),
    }));

    return NextResponse.json(safeQuestions);
  } catch (err) {
    console.error(err);

    return NextResponse.json(
      { error: "Failed to load questions" },
      { status: 500 }
    );
  }
}