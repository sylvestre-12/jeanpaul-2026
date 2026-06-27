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
    <main className="min-h-screen w-full bg-gradient-to-br from-gray-100 to-gray-200 flex flex-col items-center px-4 py-6 sm:py-10">

      {/* CARD */}
      <div className="
        w-full max-w-md
        bg-white
        rounded-2xl
        shadow-lg
        p-5 sm:p-6
        mt-6 sm:mt-10
      ">

        {/* TOP BAR */}
        <div className="flex items-center justify-between mb-5">

          {/* BACK BUTTON (BLACK + STRONG) */}
          <button
            onClick={() => router.back()}
            className="
              min-h-[44px]
              px-3 py-2
              text-sm sm:text-base
              font-bold text-black
              border border-gray-400
              rounded-xl
              hover:bg-gray-100
              transition
            "
          >
            ← Back
          </button>

          {/* LANGUAGE */}
          <div className="relative">

            <button
              onClick={() => setOpen(!open)}
              className="
                min-h-[44px]
                px-3 py-2
                text-sm
                font-semibold
                border border-gray-400
                rounded-xl
                hover:bg-gray-100
                transition
              "
            >
              🌍 {safeLang}
            </button>

            {open && (
              <div className="
                absolute right-0 mt-2
                w-44
                bg-white
                border border-gray-200
                rounded-xl
                shadow-xl
                z-[999]
                overflow-hidden
              ">
                {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                  <button
                    key={l}
                    onClick={() => {
                      changeLanguage(l);
                      setOpen(false);
                    }}
                    className="
                      w-full text-left
                      px-4 py-3
                      text-sm
                      hover:bg-gray-100
                      transition
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

        {/* TITLE */}
        <h1 className="text-xl sm:text-2xl font-extrabold text-center mb-6 text-gray-900">
          {t.signup}
        </h1>

        {/* FORM */}
        <div className="space-y-4">

          <input
            className="
              w-full
              min-h-[44px]
              p-3 sm:p-4
              border border-gray-300
              rounded-xl
              text-sm sm:text-base
              focus:ring-2 focus:ring-green-500
              outline-none
            "
            placeholder="Name"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />

          <input
            className="
              w-full
              min-h-[44px]
              p-3 sm:p-4
              border border-gray-300
              rounded-xl
              text-sm sm:text-base
              focus:ring-2 focus:ring-green-500
              outline-none
            "
            placeholder="Phone"
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />

          <input
            className="
              w-full
              min-h-[44px]
              p-3 sm:p-4
              border border-gray-300
              rounded-xl
              text-sm sm:text-base
              focus:ring-2 focus:ring-green-500
              outline-none
            "
            type="password"
            placeholder={t.password}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
        </div>

        {/* SIGNUP BUTTON */}
        <button
          onClick={signup}
          className="
            w-full mt-5
            min-h-[44px]
            bg-green-600 text-white
            p-3 sm:p-4
            rounded-xl
            font-bold
            hover:bg-green-700
            transition
            focus:outline-none focus:ring-2 focus:ring-green-400
          "
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