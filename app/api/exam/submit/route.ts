import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  try {
    const body = await req.json();

    const { userId, score, total, answers } = body;

    // 1. Create result first
    const result = await prisma.result.create({
      data: {
        userId: Number(userId),
        score,
        total,
      },
    });

    // 2. Then create answers linked to resultId
    await prisma.userAnswer.createMany({
      data: answers.map((a: any) => ({
        resultId: result.id,
        questionId: a.questionId,
        optionId: a.optionId,
      })),
    });

    return NextResponse.json({
      success: true,
      resultId: result.id,
    });

  } catch (error) {
    console.error("EXAM SUBMIT ERROR:", error);

    return NextResponse.json(
      { error: "Failed to save result" },
      { status: 500 }
    );
  }
}