"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useLanguage } from "@/lib/useLanguage";
import { translations } from "@/i18n/translations";

type Lang = "EN" | "FR" | "RW";

export default function SignupPage() {
  const router = useRouter();
  const { lang, changeLanguage } = useLanguage();

  const safeLang: Lang = (lang as Lang) || "EN";
  const t = translations[safeLang] || translations.EN;

  const [name, setName] = useState("");
  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [open, setOpen] = useState(false);

  async function signup() {
    const res = await fetch("/api/auth/signup", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name, phone, password }),
    });

    const data = await res.json();

    if (data.id) {
      router.push("/auth/login");
    } else {
      alert(data.error || "Signup failed");
    }
  }

  return (
    <main className="min-h-dvh w-full flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 px-4">

      <div className="w-full max-w-md bg-white rounded-2xl shadow-lg p-5 sm:p-6">

        {/* HEADER */}
        <div className="flex items-center justify-between mb-5">

          <button
            onClick={() => router.back()}
            className="min-h-[44px] px-3 py-2 text-sm font-bold border rounded-xl"
          >
            {t.back}
          </button>

          <div className="relative">
            <button
              onClick={() => setOpen(!open)}
              className="min-h-[44px] px-3 py-2 text-sm border rounded-xl"
            >
              🌍 {safeLang}
            </button>

            {open && (
              <div className="absolute right-0 mt-2 w-44 bg-white border rounded-xl shadow-xl z-50">
                {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                  <button
                    key={l}
                    onClick={() => {
                      changeLanguage(l);
                      setOpen(false);
                    }}
                    className="w-full text-left px-4 py-3 text-sm hover:bg-gray-100"
                  >
                    {l}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* TITLE */}
        <h1 className="text-xl font-bold text-center mb-6">
          {t.signup}
        </h1>

        {/* FORM */}
        <div className="space-y-4">
<label className="text-sm font-semibold text-gray-700">
              {t.name}
            </label>
          <input
            className="w-full min-h-[44px] p-3 border rounded-xl"
            placeholder={t.name}
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
<label className="text-sm font-semibold text-gray-700">
              {t.phone}
            </label>
          <input
            className="w-full min-h-[44px] p-3 border rounded-xl"
            placeholder={t.phone}
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />
           <label className="text-sm font-semibold text-gray-700">
              {t.password}
            </label>
          <input
            className="w-full min-h-[44px] p-3 border rounded-xl"
            type="password"
            placeholder={t.password}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>

        {/* BUTTON */}
        <button
          onClick={signup}
          className="w-full mt-5 min-h-[44px] bg-green-600 text-white rounded-xl font-bold"
        >
          {t.signup}
        </button>

        {/* LINKS */}
        <div className="flex justify-between mt-5 text-sm flex-wrap gap-2">

          <button
            onClick={() => router.push("/auth/forgot-password")}
            className="text-blue-600 font-semibold hover:underline"
          >
            {t.forgotPassword}
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            className="text-green-600 font-semibold hover:underline"
          >
            {t.login}
          </button>

        </div>

      </div>
    </main>
  );
}