import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// ======================================================
// GET RANDOM 20 QUESTIONS (MEMBER)
// ======================================================
export async function GET() {
  try {
    const allQuestions = await prisma.question.findMany({
      where: {
        deleted: false,
      },
      include: {
        translations: true,
        options: {
          include: {
            translations: true,
          },
        },
        images: true,
      },
    });

    const shuffledQuestions = [...allQuestions].sort(
      () => Math.random() - 0.5
    );

    const selectedQuestions = shuffledQuestions.slice(0, 20);

    const finalQuestions = selectedQuestions.map((question) => ({
      ...question,
      options: [...question.options].sort(() => Math.random() - 0.5),
    }));

    return NextResponse.json(finalQuestions);
  } catch (error) {
    console.error("GET TEST ERROR:", error);

    return NextResponse.json(
      {
        success: false,
        error: "Failed to load questions",
      },
      { status: 500 }
    );
  }
}

// ======================================================
// SUBMIT TEST (MEMBER)
// ======================================================
export async function POST(req: Request) {
  try {
    const body = await req.json();

    const userId = Number(body.userId);
    const answers = body.answers;

    if (!userId || isNaN(userId)) {
      return NextResponse.json(
        { success: false, error: "Valid User ID is required" },
        { status: 400 }
      );
    }

    if (!Array.isArray(answers)) {
      return NextResponse.json(
        { success: false, error: "Answers are required" },
        { status: 400 }
      );
    }

    let score = 0;

    for (const answer of answers) {
      const questionId = Number(answer.questionId);
      const optionId = Number(answer.optionId);

      if (!questionId || !optionId) continue;

      const question = await prisma.question.findUnique({
        where: { id: questionId },
        include: {
          options: true,
        },
      });

      if (!question) continue;

      const correctOption = question.options.find(
        (option: any) => option.isCorrect
      );

      if (correctOption && correctOption.id === optionId) {
        score++;
      }
    }

    const total = answers.length;

    const result = await prisma.result.create({
      data: {
        userId,
        score,
        total,
      },
    });

    await prisma.userAnswer.createMany({
      data: answers.map((answer: any) => ({
        resultId: result.id,
        questionId: Number(answer.questionId),
        optionId: Number(answer.optionId),
      })),
    });

    return NextResponse.json({
      success: true,
      message: score >= 12 ? "Congratulations" : "Completed",
      score,
      total,
      passed: score >= 12,
      failed: score < 12,
      result,
    });
  } catch (error) {
    console.error("SUBMIT TEST ERROR:", error);

    return NextResponse.json(
      {
        success: false,
        error: "Failed to submit test",
      },
      { status: 500 }
    );
  }
}