import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

type Language = "EN" | "FR" | "RW";

export async function POST(req: Request) {
  try {
    // Read request body
    const body = await req.json();

    const {
      userId,
      score,
      total,
      language,
      answers,
    }: {
      userId: number | string;
      score: number;
      total: number;
      language: Language;
      answers: {
        questionId: number;
        optionId: number;
      }[];
    } = body;

    // --------------------------------------------------
    // 1. Validate user ID
    // --------------------------------------------------

    const numericUserId = Number(userId);

    if (!userId || Number.isNaN(numericUserId)) {
      return NextResponse.json(
        {
          success: false,
          error: "Valid user ID is required",
        },
        { status: 400 }
      );
    }

    // --------------------------------------------------
    // 2. Validate language
    // --------------------------------------------------

    const validLanguages: Language[] = ["EN", "FR", "RW"];

    if (!validLanguages.includes(language)) {
      return NextResponse.json(
        {
          success: false,
          error: "Valid language is required: EN, FR, or RW",
        },
        { status: 400 }
      );
    }

    // --------------------------------------------------
    // 3. Validate score and total
    // --------------------------------------------------

    const numericScore = Number(score);
    const numericTotal = Number(total);

    if (Number.isNaN(numericScore) || Number.isNaN(numericTotal)) {
      return NextResponse.json(
        {
          success: false,
          error: "Score and total must be valid numbers",
        },
        { status: 400 }
      );
    }

    // --------------------------------------------------
    // 4. Validate answers
    // --------------------------------------------------

    if (!Array.isArray(answers)) {
      return NextResponse.json(
        {
          success: false,
          error: "Answers must be an array",
        },
        { status: 400 }
      );
    }

    // --------------------------------------------------
    // 5. Create the exam result
    // --------------------------------------------------

    const result = await prisma.result.create({
      data: {
        userId: numericUserId,
        score: numericScore,
        total: numericTotal,

        // VERY IMPORTANT:
        // Save the language in which this exam was taken.
        language,
      },
    });

    // --------------------------------------------------
    // 6. Save the student's answers
    // --------------------------------------------------

    if (answers.length > 0) {
      await prisma.userAnswer.createMany({
        data: answers.map((answer) => ({
          resultId: result.id,
          questionId: Number(answer.questionId),
          optionId: Number(answer.optionId),
        })),
      });
    }

    // --------------------------------------------------
    // 7. Return success response
    // --------------------------------------------------

    return NextResponse.json({
      success: true,
      resultId: result.id,
      language: result.language,
      score: result.score,
      total: result.total,
    });
  } catch (error) {
    console.error("EXAM SUBMIT ERROR:", error);

    return NextResponse.json(
      {
        success: false,
        error: "Failed to save exam result",
      },
      { status: 500 }
    );
  }
}