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
    } catch (err) {
      alert("Server error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 px-3 sm:px-4">

      {/* CARD */}
      <div className="w-full max-w-sm sm:max-w-md bg-white rounded-2xl shadow-xl p-5 sm:p-6">

        {/* HEADER */}
        <div className="flex justify-between items-center mb-6">

          {/* BACK */}
          <button
            onClick={() => router.push("/")}
            className="text-sm sm:text-base px-3 py-1 rounded-lg border hover:bg-gray-100 transition"
          >
            ← Back
          </button>

          {/* LANGUAGE */}
          <div className="relative">
            <button
              onClick={() => setOpen(!open)}
              className="text-sm px-3 py-1 rounded-lg border hover:bg-gray-100"
            >
              🌍 {safeLang}
            </button>

            {open && (
              <div className="absolute right-0 mt-2 w-44 bg-white border rounded-lg shadow-lg z-50">
                {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                  <button
                    key={l}
                    onClick={() => {
                      setLang(l);
                      setOpen(false);
                    }}
                    className="w-full text-left px-4 py-2 text-sm hover:bg-gray-100"
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

        {/* TITLE */}
        <h1 className="text-xl sm:text-2xl font-bold text-center mb-6 text-gray-800">
          {t.login || "Login"}
        </h1>

        {/* FORM */}
        <div className="space-y-4">

          <input
            className="w-full p-3 sm:p-4 border rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm sm:text-base"
            placeholder="Phone"
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />

          <input
            className="w-full p-3 sm:p-4 border rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm sm:text-base"
            type="password"
            placeholder={t.password || "Password"}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />

          <button
            onClick={handleLogin}
            disabled={loading}
            className={`w-full p-3 sm:p-4 rounded-xl font-semibold text-white transition
              ${loading ? "bg-blue-400" : "bg-blue-600 hover:bg-blue-700"}`}
          >
            {loading ? "Logging in..." : t.login || "Login"}
          </button>
        </div>

        {/* LINKS */}
        <div className="flex justify-between mt-5 text-sm">

          <button
            onClick={() => router.push("/auth/forgot-password")}
            className="text-blue-600 hover:underline"
          >
            {t.forgotPassword || "Forgot Password?"}
          </button>

          <button
            onClick={() => router.push("/auth/signup")}
            className="text-green-600 hover:underline"
          >
            {t.signup || "Sign Up"}
          </button>

        </div>

      </div>
    </main>
  );
}