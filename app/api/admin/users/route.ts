import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// GET ALL USERS (admin panel)
export async function GET() {
  try {
    const users = await prisma.user.findMany({
      orderBy: {
        createdAt: "desc",
      },
    });

    return NextResponse.json(users);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to fetch users" },
      { status: 500 }
    );
  }
}

// DELETE USER (admin)
export async function DELETE(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const id = Number(searchParams.get("id"));

    if (!id) {
      return NextResponse.json(
        { error: "User id required" },
        { status: 400 }
      );
    }

    await prisma.user.delete({
      where: { id },
    });

    return NextResponse.json({
      message: "User deleted successfully",
    });
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to delete user" },
      { status: 500 }
    );
  }
}

// APPROVE / DENY USER
export async function PATCH(req: Request) {
  try {
    const { id, approved } = await req.json();

    const updated = await prisma.user.update({
      where: { id },
      data: {
        approved,
      },
    });

    return NextResponse.json(updated);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to update user" },
      { status: 500 }
    );
  }
}