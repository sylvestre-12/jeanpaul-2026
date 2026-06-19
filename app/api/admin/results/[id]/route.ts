import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function DELETE(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params;

    const resultId = Number(id);

    if (isNaN(resultId)) {
      return NextResponse.json(
        { error: "Invalid result ID" },
        { status: 400 }
      );
    }

    // Delete all answers linked to this result first
    await prisma.userAnswer.deleteMany({
      where: {
        resultId,
      },
    });

    // Delete the result
    await prisma.result.delete({
      where: {
        id: resultId,
      },
    });

    return NextResponse.json({
      success: true,
      message: "Result deleted successfully",
    });
  } catch (error) {
    console.error("DELETE RESULT ERROR:", error);

    return NextResponse.json(
      {
        success: false,
        error: "Delete failed",
      },
      {
        status: 500,
      }
    );
  }
}