import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import bcrypt from "bcrypt";

export async function POST(req: Request) {
  try {
    const { name, phone, password } = await req.json();

    // ✅ validation
    if (!name || !phone || !password) {
      return NextResponse.json(
        { error: "Name, phone and password are required" },
        { status: 400 }
      );
    }

    // check if user exists
    const existing = await prisma.user.findUnique({
      where: { phone },
    });

    if (existing) {
      return NextResponse.json(
        { error: "Phone already exists" },
        { status: 400 }
      );
    }

    // hash password
    const hashed = await bcrypt.hash(password, 10);

    // create user in PostgreSQL
    const user = await prisma.user.create({
      data: {
        name,
        phone,
        password: hashed,
        approved: false,
      },
    });

    // response
    return NextResponse.json({
      id: user.id,
      name: user.name,
      phone: user.phone,
      approved: user.approved,
    });

  } catch (error) {
    console.error("Signup error:", error);
    return NextResponse.json(
      { error: "Server error" },
      { status: 500 }
    );
  }
}