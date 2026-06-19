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
  const t = translations[safeLang];

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
    <main className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 px-3 sm:px-4">

      <div className="w-full max-w-md bg-white p-5 sm:p-6 rounded-2xl shadow-lg">

        {/* TOP BAR */}
        <div className="flex justify-between items-center mb-5">

          {/* BACK BUTTON */}
          <button
            onClick={() => router.back()}
            className="text-sm bg-gray-800 text-white px-3 py-1 rounded hover:bg-gray-700 transition"
          >
            ← Back
          </button>

          {/* LANGUAGE SELECT */}
          <div className="relative">
            <button
              onClick={() => setOpen(!open)}
              className="border px-3 py-1 rounded text-sm hover:bg-gray-100 transition"
            >
              🌍 {lang}
            </button>

            {open && (
              <div className="absolute right-0 mt-2 bg-white shadow-lg border rounded w-40 z-50 overflow-hidden">

                {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                  <button
                    key={l}
                    onClick={() => {
                      changeLanguage(l);
                      setOpen(false);
                    }}
                    className="w-full text-left px-3 py-2 text-sm hover:bg-gray-100 transition"
                  >
                    {l}
                  </button>
                ))}

              </div>
            )}
          </div>
        </div>

        {/* TITLE */}
        <h1 className="text-2xl font-bold text-center mb-6 text-gray-800">
          {t.signup}
        </h1>

        {/* FORM */}
        <div className="space-y-3">

          <input
            className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-green-500"
            placeholder="Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />

          <input
            className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-green-500"
            placeholder="Phone"
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />

          <input
            className="w-full p-3 border rounded-lg outline-none focus:ring-2 focus:ring-green-500"
            type="password"
            placeholder={t.password}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />

        </div>

        {/* SIGNUP BUTTON */}
        <button
          onClick={signup}
          className="w-full mt-5 bg-green-600 text-white p-3 rounded-lg font-semibold hover:bg-green-700 transition active:scale-[0.98]"
        >
          {t.signup}
        </button>

        {/* LINKS */}
        <div className="flex justify-between mt-4 text-sm">

          <button
            onClick={() => router.push("/auth/forgot-password")}
            className="text-blue-600 hover:underline"
          >
            {t.forgotPassword}
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            className="text-green-600 hover:underline font-medium"
          >
            {t.login}
          </button>

        </div>

      </div>
    </main>
  );
}