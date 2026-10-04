import { cookies } from "next/headers";
import jwt from "jsonwebtoken";
import { prisma } from "@/lib/prisma";

const JWT_SECRET = process.env.JWT_SECRET!;

export async function getCurrentUser() {
  try {
    const cookieStore = await cookies();

    const token = cookieStore.get("nutrigrow_token")?.value;

    if (!token) return null;

    const decoded = jwt.verify(token, JWT_SECRET) as any;

    const user = await prisma.user.findUnique({
      where: { id: decoded.id },
    });

    return user;
  } catch (err) {
    console.error("Auth error:", err);
    return null;
  }
}