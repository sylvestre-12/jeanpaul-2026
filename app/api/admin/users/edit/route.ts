import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

// =========================
// EDIT USER
// =========================
export async function PUT(
  req: Request
) {

  try {

    const {
      id,
      name,
      phone,
    } = await req.json();

    // validate
    if (!id) {

      return NextResponse.json(
        {
          error:
            "User ID required",
        },
        { status: 400 }
      );
    }

    // check existing user
    const existingUser =
      await prisma.user.findUnique({
        where: { id },
      });

    if (!existingUser) {

      return NextResponse.json(
        {
          error:
            "User not found",
        },
        { status: 404 }
      );
    }

    // update user
    const updatedUser =
      await prisma.user.update({
        where: { id },

        data: {
          name,
          phone,
        },
      });

    return NextResponse.json({
      message:
        "User updated successfully",

      user: updatedUser,
    });

  } catch (error) {

    console.error(
      "EDIT USER ERROR:",
      error
    );

    return NextResponse.json(
      {
        error:
          "Failed to edit user",
      },
      { status: 500 }
    );
  }
}