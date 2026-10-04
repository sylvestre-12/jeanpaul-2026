import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import jwt from "jsonwebtoken";

export async function POST(req: Request) {
  try {
    const { userId, otp } = await req.json();

    if (!userId || !otp) {
      return NextResponse.json(
        { error: "MISSING_FIELDS" },
        { status: 400 }
      );
    }

    const id = Number(userId);

    const cleanOtp = otp.toString().trim();

    const record = await prisma.oTP.findFirst({
      where: {
        userId: id,
        used: false,
      },
      orderBy: {
        id: "desc",
      },
    });

    if (!record) {
      return NextResponse.json(
        { error: "OTP_NOT_FOUND" },
        { status: 400 }
      );
    }

    // IMPORTANT
    if (record.code.toString() !== cleanOtp) {
      return NextResponse.json(
        { error: "INVALID_OTP" },
        { status: 400 }
      );
    }

    if (new Date() > record.expiresAt) {
      return NextResponse.json(
        { error: "OTP_EXPIRED" },
        { status: 400 }
      );
    }

    // mark OTP used
    await prisma.oTP.update({
      where: { id: record.id },
      data: { used: true },
    });

    const user = await prisma.user.findUnique({
      where: { id },
    });

    if (!user) {
      return NextResponse.json(
        { error: "USER_NOT_FOUND" },
        { status: 404 }
      );
    }

    const token = jwt.sign(
      {
        userId: user.id,
        role: user.role,
        approved: user.approved,
      },
      process.env.JWT_SECRET!,
      { expiresIn: "1d" }
    );

    let redirect = "/user/dashboard";

    if (user.role === "ADMIN") {
      redirect = "/admin/dashboard";
    } else if (!user.approved) {
      redirect = "/notapproved";
    }

    return NextResponse.json({
      message: "LOGIN_SUCCESS",
      token,
      redirect,
      role: user.role,
      approved: user.approved,
    });

  } catch (error) {
    console.error(error);

    return NextResponse.json(
      { error: "SERVER_ERROR" },
      { status: 500 }
    );
  }
}