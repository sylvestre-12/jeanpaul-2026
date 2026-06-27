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
    <nav className="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b">
      <div className="max-w-7xl mx-auto px-4 py-3 flex flex-wrap items-center justify-between gap-3">

        {/* LOGO */}
        <Link
          href="/"
          className="
            text-base sm:text-lg md:text-xl
            font-bold text-gray-800
            min-h-[44px]
            flex items-center
          "
        >
          🚦 Traffic System
        </Link>

        {/* RIGHT SIDE */}
        <div className="flex flex-wrap items-center gap-2 sm:gap-3">

          <LanguageSwitcher />

          {/* NOT LOGGED IN */}
          {!role && (
            <>
              <button
                onClick={() => router.push("/auth/login")}
                className="
                  min-h-[44px]
                  px-4 py-2
                  text-sm sm:text-base
                  border border-gray-300
                  rounded-xl
                  text-gray-700
                  hover:bg-gray-100
                  transition
                  focus:outline-none focus:ring-2 focus:ring-gray-300
                "
              >
                Login
              </button>

              <button
                onClick={() => router.push("/auth/signup")}
                className="
                  min-h-[44px]
                  px-4 py-2
                  text-sm sm:text-base
                  bg-blue-600 text-white
                  rounded-xl
                  hover:bg-blue-700
                  transition
                  focus:outline-none focus:ring-2 focus:ring-blue-400
                "
              >
                Sign Up
              </button>
            </>
          )}

          {/* LOGGED IN */}
          {role && (
            <>
              <span
                className="
                  hidden sm:block
                  text-xs sm:text-sm
                  text-gray-600
                  px-2
                "
              >
                {role}
              </span>

              <button
                onClick={logout}
                className="
                  min-h-[44px]
                  px-4 py-2
                  text-sm sm:text-base
                  bg-red-500 text-white
                  rounded-xl
                  hover:bg-red-600
                  transition
                  focus:outline-none focus:ring-2 focus:ring-red-300
                "
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