import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// ==============================
// GET USER RESULTS
// ==============================
export async function GET(req: Request) {
try {
const { searchParams } = new URL(req.url);


const userId = Number(searchParams.get("userId"));

if (!userId || isNaN(userId)) {
  return NextResponse.json(
    { error: "Valid userId required" },
    { status: 400 }
  );
}

const results = await prisma.result.findMany({
  where: {
    userId,
  },
  orderBy: {
    createdAt: "desc",
  },
  include: {
    user: true,
    answers: {
      include: {
        question: {
          include: {
            translations: true,
            options: {
              include: {
                translations: true,
              },
            },
          },
        },
      },
    },
  },
});

return NextResponse.json(results, {
  status: 200,
});


} catch (error) {
console.error("GET RESULTS ERROR:", error);


return NextResponse.json(
  {
    error: "Failed to fetch results",
  },
  {
    status: 500,
  }
);

}
}

// ==============================
// CREATE RESULT
// ==============================
export async function POST(req: Request) {
try {
const body = await req.json();
const userId = Number(body.userId);
const score = Number(body.score);
const total = Number(body.total);
const answers = body.answers || [];

if (!userId || isNaN(userId)) {
  return NextResponse.json(
    {
      error: "Valid userId required",
    },
    {
      status: 400,
    }
  );
}

if (isNaN(score)) {
  return NextResponse.json(
    {
      error: "Valid score required",
    },
    {
      status: 400,
    }
  );
}

if (isNaN(total)) {
  return NextResponse.json(
    {
      error: "Valid total required",
    },
    {
      status: 400,
    }
  );
}

const existingUser = await prisma.user.findUnique({
  where: {
    id: userId,
  },
});

if (!existingUser) {
  return NextResponse.json(
    {
      error: "User not found",
    },
    {
      status: 404,
    }
  );
}

// Create result
const result = await prisma.result.create({
  data: {
    score,
    total,
    userId,
  },
});

// Save answers
if (answers.length > 0) {
  await prisma.userAnswer.createMany({
    data: answers.map(
      (answer: {
        questionId: number;
        optionId: number;
      }) => ({
        resultId: result.id,
        questionId: answer.questionId,
        optionId: answer.optionId,
      })
    ),
  });
}

const savedResult = await prisma.result.findUnique({
  where: {
    id: result.id,
  },
  include: {
    user: true,
    answers: {
      include: {
        question: {
          include: {
            translations: true,
            options: {
              include: {
                translations: true,
              },
            },
          },
        },
      },
    },
  },
});

return NextResponse.json(savedResult, {
  status: 201,
});


} catch (error) {
console.error("CREATE RESULT ERROR:", error);


return NextResponse.json(
  {
    error: "Failed to save result",
  },
  {
    status: 500,
  }
);

}
}
