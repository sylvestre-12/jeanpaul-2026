import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import bcrypt from "bcrypt";
import nodemailer from "nodemailer";

const ADMIN_PHONE = "0786278953";
const ADMIN_EMAIL = "120tegeri@gmail.com";

export async function POST(req: Request) {
  try {

    const { phone, password } = await req.json();

    // validate
    if (!phone || !password) {
      return NextResponse.json(
        { error: "MISSING_FIELDS" },
        { status: 400 }
      );
    }

    // user
    const user = await prisma.user.findUnique({
      where: { phone },
    });

    if (!user) {
      return NextResponse.json(
        {
          error: "USER_NOT_FOUND_CREATE_ACCOUNT",
        },
        { status: 404 }
      );
    }

    // password
    const valid = await bcrypt.compare(
      password,
      user.password
    );

    if (!valid) {
      return NextResponse.json(
        { error: "INVALID_CREDENTIALS" },
        { status: 401 }
      );
    }

    const isAdmin =
      phone === ADMIN_PHONE;

    // =========================
    // ADMIN LOGIN
    // =========================
    if (isAdmin) {

      const otp = generateOTP();

      // save otp
      await prisma.oTP.create({
        data: {
          code: otp,
          userId: user.id,
          expiresAt: new Date(
            Date.now() + 5 * 60 * 1000
          ),
          used: false,
        },
      });

      // send email
      await sendOTP(
        ADMIN_EMAIL,
        otp
      );

      console.log("OTP:", otp);

      return NextResponse.json({
        message: "ADMIN_OTP_SENT",
        userId: user.id,
        name: user.name,   // ✅ ADDED
        phone: user.phone, // ✅ ADDED
        role: "ADMIN",
        redirect: "/auth/otp",
      });
    }

    // =========================
    // NOT APPROVED
    // =========================
    if (!user.approved) {
      return NextResponse.json(
        {
          error:
            "WAIT_ADMIN_TO_APPROVE_OR_CONTACT_0786278953",
        },
        { status: 403 }
      );
    }

    // =========================
    // NORMAL USER
    // =========================
    return NextResponse.json({
      message: "LOGIN_SUCCESS",
      userId: user.id,
      name: user.name,   // ✅ ADDED
      phone: user.phone, // ✅ ADDED
      role: user.role,
      redirect: "/user/dashboard",
    });

  } catch (error) {

    console.error(
      "LOGIN ERROR:",
      error
    );

    return NextResponse.json(
      { error: "SERVER_ERROR" },
      { status: 500 }
    );
  }
}

async function sendOTP(
  email: string,
  otp: string
) {

  const transporter =
    nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS,
      },
    });

  await transporter.sendMail({
    from:
      `"Traffic System" <${process.env.EMAIL_USER}>`,
    to: email,
    subject: "Admin OTP Code",
    text: `Your OTP is: ${otp}`,
  });

  console.log(
    "✅ OTP SENT TO ADMIN:",
    email
  );
}

function generateOTP() {
  return Math.floor(
    100000 + Math.random() * 900000
  ).toString();
}