import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function GET() {
  try {
    const results = await prisma.result.findMany({
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

    return NextResponse.json(results);
  } catch (error) {
    console.error("RESULTS ERROR:", error);

    return NextResponse.json(
      {
        error: "Failed to load results",
      },
      {
        status: 500,
      }
    );
  }
}