"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useLanguage } from "@/i18n/LanguageProvider";
import { translations } from "@/i18n/translations";
import { LANG_KEY } from "@/lib/language";

type Lang = "EN" | "FR" | "RW";

export default function LoginPage() {
  const router = useRouter();
  const { lang, setLang } = useLanguage();

  const safeLang: Lang = (lang as Lang) || "EN";
  const t = translations[safeLang] || translations.EN;

  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [open, setOpen] = useState(false);
  const [loading, setLoading] = useState(false);

  async function handleLogin() {
    if (!phone || !password) {
      alert("Please fill all fields");
      return;
    }

    setLoading(true);

    try {
      const res = await fetch("/api/auth/login", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phone, password }),
      });

      const data = await res.json();

      if (data.error) {
        alert(data.error);
        return;
      }

      await setLang(lang);

      localStorage.setItem("userId", data.userId);
      localStorage.setItem("userName", data.name || "");
      localStorage.setItem("userPhone", data.phone || "");
      localStorage.setItem("app_lang", lang);
      localStorage.setItem(LANG_KEY, lang);

      router.push(
        data.redirect === "/user/dashboard"
          ? "/user/dashboard"
          : "/auth/otp"
      );
    } catch {
      alert("Server error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-dvh w-full flex flex-col bg-gradient-to-br from-gray-100 to-gray-200 px-4 py-6">

      {/* CENTER WRAPPER (FIX MOBILE SPACING) */}
      <div className="flex-1 w-full flex items-start justify-center">

        <div className="w-full max-w-md bg-white rounded-2xl shadow-md sm:shadow-lg p-5 sm:p-6">

          {/* HEADER (FIX MOBILE WRAP ISSUE) */}
          <div className="flex items-center justify-between gap-2 mb-6">

            {/* BACK */}
            <button
              onClick={() => router.push("/")}
              className="
                min-h-[44px]
                px-3 py-2
                text-sm font-bold text-black
                border border-gray-400
                rounded-xl
                hover:bg-gray-100
                whitespace-nowrap
              "
            >
              ← Back
            </button>

            {/* TITLE (PREVENT OVERFLOW) */}
            <h1 className="text-sm sm:text-xl font-extrabold text-center text-gray-900 flex-1">
              {t.login || "Login"}
            </h1>

            {/* LANGUAGE */}
            <div className="relative">

              <button
                onClick={() => setOpen(!open)}
                className="
                  min-h-[44px]
                  px-3 py-2
                  text-sm font-bold
                  border border-gray-400
                  rounded-xl
                  hover:bg-gray-100
                "
              >
                🌍 {safeLang}
              </button>

              {open && (
                <div className="absolute right-0 mt-2 w-44 bg-white border rounded-xl shadow-xl z-50 overflow-hidden">

                  {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                    <button
                      key={l}
                      onClick={() => {
                        setLang(l);
                        setOpen(false);
                      }}
                      className="
                        w-full text-left px-4 py-3
                        text-sm font-medium
                        hover:bg-gray-100
                      "
                    >
                      {l === "EN" && "English"}
                      {l === "FR" && "Français"}
                      {l === "RW" && "Kinyarwanda"}
                    </button>
                  ))}

                </div>
              )}
            </div>

          </div>

          {/* FORM */}
          <div className="space-y-4">

            <label className="text-sm font-semibold text-gray-700">
              Phone
            </label>

            <input
              className="
                w-full
                min-h-[44px]
                p-3
                border border-gray-300
                rounded-xl
                focus:ring-2 focus:ring-blue-500
                text-sm sm:text-base
              "
              placeholder="Enter phone number"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
            />

            <label className="text-sm font-semibold text-gray-700">
              Password
            </label>

            <input
              className="
                w-full
                min-h-[44px]
                p-3
                border border-gray-300
                rounded-xl
                focus:ring-2 focus:ring-blue-500
                text-sm sm:text-base
              "
              type="password"
              placeholder="Enter password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />

            <button
              onClick={handleLogin}
              disabled={loading}
              className={`
                w-full
                min-h-[44px]
                rounded-xl
                font-bold text-white
                transition
                ${
                  loading
                    ? "bg-blue-400"
                    : "bg-blue-600 hover:bg-blue-700"
                }
              `}
            >
              {loading ? "Logging in..." : t.login || "Login"}
            </button>

          </div>

          {/* LINKS */}
          <div className="flex justify-between mt-5 text-sm flex-wrap gap-2">

            <button
              onClick={() => router.push("/auth/forgot-password")}
              className="text-blue-600 font-semibold hover:underline"
            >
              Forgot Password?
            </button>

            <button
              onClick={() => router.push("/auth/signup")}
              className="text-green-600 font-semibold hover:underline"
            >
              Sign Up
            </button>

          </div>

        </div>
      </div>
    </main>
  );
}