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

    // Shuffle questions
    const shuffledQuestions = [...allQuestions].sort(
      () => Math.random() - 0.5
    );

    // Select maximum 20 questions
    const selectedQuestions = shuffledQuestions.slice(0, 20);

    // Shuffle options for each question
    const finalQuestions = selectedQuestions.map((question) => ({
      ...question,
      options: [...question.options].sort(
        () => Math.random() - 0.5
      ),
    }));

    console.log(
      "TEST QUESTIONS LOADED:",
      finalQuestions.length
    );

    return NextResponse.json(finalQuestions);
  } catch (error) {
    console.error("GET TEST ERROR:", error);

    return NextResponse.json(
      {
        success: false,
        error: "Failed to load questions",
      },
      {
        status: 500,
      }
    );
  }
}

// ======================================================
// POST - SUBMIT TEST (MEMBER)
// ======================================================
export async function POST(req: Request) {
  try {
    const body = await req.json();

    const userId = Number(body.userId);
    const answers = body.answers;

    console.log("SUBMIT TEST REQUEST:", {
      userId,
      answersCount: Array.isArray(answers)
        ? answers.length
        : 0,
    });

    // ==================================================
    // VALIDATE USER ID
    // ==================================================
    if (!userId || isNaN(userId)) {
      return NextResponse.json(
        {
          success: false,
          error: "Valid User ID is required",
        },
        {
          status: 400,
        }
      );
    }

    // ==================================================
    // VALIDATE ANSWERS
    // ==================================================
    if (!Array.isArray(answers)) {
      return NextResponse.json(
        {
          success: false,
          error: "Answers are required",
        },
        {
          status: 400,
        }
      );
    }

    // ==================================================
    // CHECK THAT USER EXISTS
    // ==================================================
    const user = await prisma.user.findUnique({
      where: {
        id: userId,
      },
    });

    if (!user) {
      console.error(
        "SUBMIT TEST ERROR: USER NOT FOUND:",
        userId
      );

      return NextResponse.json(
        {
          success: false,
          error: "User not found",
        },
        {
          status: 404,
        }
      );
    }

    // ==================================================
    // CALCULATE SCORE
    // ==================================================
    let score = 0;

    for (const answer of answers) {
      const questionId = Number(answer.questionId);
      const optionId = Number(answer.optionId);

      // Skip invalid answers
      if (!questionId || !optionId) {
        continue;
      }

      // Find question and its options
      const question = await prisma.question.findUnique({
        where: {
          id: questionId,
        },
        include: {
          options: true,
        },
      });

      if (!question) {
        console.warn(
          "QUESTION NOT FOUND:",
          questionId
        );
        continue;
      }

      // Find correct option
      const correctOption = question.options.find(
        (option) => option.isCorrect === true
      );

      // Compare user's answer with correct answer
      if (
        correctOption &&
        correctOption.id === optionId
      ) {
        score++;
      }
    }

    // ==================================================
    // EXAM TOTAL
    // ==================================================
    // The exam is designed to contain 20 questions.
    const total = 20;

    // ==================================================
    // SAVE RESULT
    // ==================================================
    const result = await prisma.result.create({
      data: {
        userId,
        score,
        total,
      },
    });

    console.log("TEST RESULT CREATED:", {
      resultId: result.id,
      userId,
      score,
      total,
    });

    // ==================================================
    // SAVE USER ANSWERS
    // ==================================================
    const validAnswers = answers
      .map((answer: any) => ({
        resultId: result.id,
        questionId: Number(answer.questionId),
        optionId: Number(answer.optionId),
      }))
      .filter(
        (answer: any) =>
          answer.questionId > 0 &&
          answer.optionId > 0
      );

    if (validAnswers.length > 0) {
      await prisma.userAnswer.createMany({
        data: validAnswers,
      });
    }

    console.log("USER ANSWERS SAVED:", {
      resultId: result.id,
      answersSaved: validAnswers.length,
    });

    // ==================================================
    // PASS / FAIL
    // ==================================================
    const passed = score >= 12;
    const failed = score < 12;

    // ==================================================
    // RESPONSE
    // ==================================================
    return NextResponse.json(
      {
        success: true,
        message: passed
          ? "Congratulations"
          : "Completed",

        score,
        total,
        passed,
        failed,

        result: {
          id: result.id,
          userId: result.userId,
          score: result.score,
          total: result.total,
          createdAt: result.createdAt,
        },
      },
      {
        status: 200,
      }
    );
  } catch (error) {
    console.error(
      "SUBMIT TEST ERROR:",
      error
    );

    return NextResponse.json(
      {
        success: false,
        error: "Failed to submit test",
      },
      {
        status: 500,
      }
    );
  }
}