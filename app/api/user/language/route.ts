import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  try {
    const { userId, language } = await req.json();

    await prisma.user.update({
      where: { id: Number(userId) },
      data: { language },
    });

    return NextResponse.json({ message: "LANG_UPDATED" });
  } catch (error) {
    return NextResponse.json(
      { error: "SERVER_ERROR" },
      { status: 500 }
    );
  }
}