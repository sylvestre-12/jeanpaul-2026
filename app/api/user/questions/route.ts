import { prisma } from "@/lib/prisma";
import { NextResponse } from "next/server";
import { Question } from "@prisma/client";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const lang = searchParams.get("lang") || "EN";

    const questions: Question[] = await prisma.question.findMany({
      where: {
        deleted: false,
      },
      orderBy: {
        number: "asc",
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

    return NextResponse.json(questions);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to load questions" },
      { status: 500 }
    );
  }
}