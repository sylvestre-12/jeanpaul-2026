"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { logout } from "@/lib/client-auth";
import LanguageSwitcher from "./LanguageSwitcher";

interface NavbarProps {
  role?: "ADMIN" | "USER" | null;
}

export default function Navbar({ role }: NavbarProps) {
  const router = useRouter();

  return (
    <nav className="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b">
      <div className="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">

        {/* LOGO */}
        <Link href="/" className="text-lg md:text-xl font-bold text-gray-800">
          🚦 Traffic System
        </Link>

        {/* RIGHT SIDE */}
        <div className="flex items-center gap-3">

          <LanguageSwitcher />

          {!role && (
            <>
              <button
                onClick={() => router.push("/auth/login")}
                className="px-4 py-2 text-sm md:text-base border rounded-lg hover:bg-gray-100"
              >
                Login
              </button>

              <button
                onClick={() => router.push("/auth/signup")}
                className="px-4 py-2 text-sm md:text-base bg-blue-600 text-white rounded-lg hover:bg-blue-700"
              >
                Sign Up
              </button>
            </>
          )}

          {role && (
            <>
              <span className="hidden md:block text-sm text-gray-600">
                {role}
              </span>

              <button
                onClick={logout}
                className="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600"
              >
                Logout
              </button>
            </>
          )}
        </div>
      </div>
    </nav>
  );
}