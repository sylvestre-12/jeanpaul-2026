import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import bcrypt from "bcrypt";

export async function POST(req: Request) {
  try {
    const { phone, newPassword } = await req.json();

    // ✅ 1. Validate input
    if (!phone || !newPassword) {
      return NextResponse.json(
        { error: "MISSING_FIELDS" },
        { status: 400 }
      );
    }

    if (newPassword.length < 6) {
      return NextResponse.json(
        { error: "PASSWORD_TOO_SHORT" },
        { status: 400 }
      );
    }

    // ✅ 2. Check user exists
    const user = await prisma.user.findUnique({
      where: { phone },
    });

    if (!user) {
      return NextResponse.json(
        { error: "USER_NOT_FOUND" },
        { status: 404 }
      );
    }

    // ✅ 3. Hash password securely
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // ✅ 4. Update password
    await prisma.user.update({
      where: { phone },
      data: {
        password: hashedPassword,
      },
    });

    // ✅ 5. Response
    return NextResponse.json({
      message: "PASSWORD_RESET_SUCCESS",
    });

  } catch (error) {
    console.error("RESET PASSWORD ERROR:", error);

    return NextResponse.json(
      { error: "SERVER_ERROR" },
      { status: 500 }
    );
  }
}