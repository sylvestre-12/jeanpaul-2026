import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// CREATE TEST (20 questions or any number)
export async function POST(req: Request) {
  try {
    const { title, questionIds } = await req.json();

    const test = await prisma.test.create({
      data: {
        title,
        questions: {
          connect: questionIds.map((id: number) => ({ id })),
        },
      },
    });

    return NextResponse.json(test);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to create test" },
      { status: 500 }
    );
  }
}

// GET TESTS
export async function GET() {
  try {
    const tests = await prisma.test.findMany({
      include: {
        questions: true,
      },
      orderBy: {
        id: "desc",
      },
    });

    return NextResponse.json(tests);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch tests" },
      { status: 500 }
    );
  }
}