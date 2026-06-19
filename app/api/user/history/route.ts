import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// ==============================
// GET LOGIN HISTORY
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

    const history = await prisma.loginHistory.findMany({
      where: { userId },
      orderBy: {
        createdAt: "desc",
      },
    });

    return NextResponse.json(history);
  } catch (error) {
    console.error("GET LOGIN HISTORY ERROR:", error);

    return NextResponse.json(
      { error: "Failed to fetch history" },
      { status: 500 }
    );
  }
}

// ==============================
// CREATE LOGIN HISTORY
// ==============================
export async function POST(req: Request) {
  try {
    const body = await req.json();

    const userId = Number(body.userId);

    if (!userId || isNaN(userId)) {
      return NextResponse.json(
        { error: "Valid userId required" },
        { status: 400 }
      );
    }

    const history = await prisma.loginHistory.create({
      data: {
        userId,
      },
    });

    return NextResponse.json(history, { status: 201 });
  } catch (error) {
    console.error("CREATE LOGIN HISTORY ERROR:", error);

    return NextResponse.json(
      { error: "Failed to create history" },
      { status: 500 }
    );
  }
}