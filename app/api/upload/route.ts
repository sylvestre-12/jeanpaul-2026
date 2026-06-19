import { writeFile } from "fs/promises";
import path from "path";
import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma"; // adjust path

export async function POST(req: Request) {
  try {
    const formData = await req.formData();

    const file = formData.get("file") as File;
    const questionId = Number(formData.get("questionId"));

    if (!file) {
      return NextResponse.json(
        { error: "No file uploaded" },
        { status: 400 }
      );
    }

    if (!questionId) {
      return NextResponse.json(
        { error: "Question ID required" },
        { status: 400 }
      );
    }

    const bytes = await file.arrayBuffer();
    const buffer = Buffer.from(bytes);

    const filename = Date.now() + "-" + file.name;

    const filePath = path.join(
      process.cwd(),
      "public/uploads",
      filename
    );

    await writeFile(filePath, buffer);

    const imageUrl = "/uploads/" + filename;

    // SAVE TO DATABASE
    const savedImage = await prisma.questionImage.create({
      data: {
        url: imageUrl,
        questionId: questionId,
      },
    });

    return NextResponse.json({
      success: true,
      image: savedImage,
    });

  } catch (error) {
    console.log(error);

    return NextResponse.json(
      { error: "Upload failed" },
      { status: 500 }
    );
  }
}