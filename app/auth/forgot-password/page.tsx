"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useLanguage } from "@/lib/useLanguage";
import { translations } from "@/i18n/translations";

type Lang = "EN" | "FR" | "RW";

export default function ForgotPasswordPage() {
  const router = useRouter();
  const { lang, changeLanguage } = useLanguage();

  const safeLang: Lang = (lang?.toUpperCase() as Lang) || "EN";
  const t = translations[safeLang] || translations.EN;

  const [phone, setPhone] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [open, setOpen] = useState(false);

  async function handleReset() {
    if (!phone || !newPassword) {
      alert("Please fill all fields");
      return;
    }

    setLoading(true);

    try {
      const res = await fetch("/api/auth/reset-password", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phone, newPassword }),
      });

      const data = await res.json();

      if (res.ok) {
        alert(t.redirecting || "Success");
        router.push("/auth/login");
      } else {
        alert(data.error || "Reset failed");
      }
    } catch {
      alert("Server error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-dvh w-full flex flex-col bg-gradient-to-br from-gray-100 to-gray-200 px-4 py-6">

      {/* CENTER WRAPPER */}
      <div className="flex-1 w-full flex items-center justify-center">

        <div className="w-full max-w-md bg-white rounded-2xl shadow-lg p-5 sm:p-6">

          {/* HEADER */}
          <div className="flex items-center justify-between gap-2 mb-6">

            <button
              onClick={() => router.push("/auth/login")}
              className="min-h-[44px] px-3 py-2 text-sm font-semibold border border-gray-300 rounded-xl hover:bg-gray-100"
            >
              {t.back}
            </button>

            <h1 className="text-sm sm:text-xl font-bold text-center flex-1">
              {t.forgotPassword}
            </h1>

            {/* LANGUAGE */}
            <div className="relative">

              <button
                onClick={() => setOpen(!open)}
                className="min-h-[44px] px-3 py-2 text-sm font-semibold border border-gray-300 rounded-xl hover:bg-gray-100"
              >
                🌍 {safeLang}
              </button>

              {open && (
                <div className="absolute right-0 mt-2 w-44 bg-white border rounded-xl shadow-lg z-50 overflow-hidden">

                  {(["EN", "FR", "RW"] as Lang[]).map((l) => (
                    <button
                      key={l}
                      onClick={() => {
                        changeLanguage(l);
                        setOpen(false);
                      }}
                      className="w-full text-left px-4 py-3 text-sm hover:bg-gray-100"
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

          {/* DESCRIPTION */}
          <p className="text-center text-sm text-gray-500 mb-6">
            {safeLang === "FR"
              ? "Entrez votre numéro et nouveau mot de passe"
              : safeLang === "RW"
              ? "Andika numero yawe n'ijambo ry'ibanga rishya"
              : "Enter your phone number and new password"}
          </p>

          {/* FORM */}
          <div className="space-y-4">

            <input
              className="w-full min-h-[44px] p-3 border border-gray-300 rounded-xl text-sm sm:text-base focus:ring-2 focus:ring-red-500 outline-none"
              placeholder={t.phone}
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
            />

            <input
              className="w-full min-h-[44px] p-3 border border-gray-300 rounded-xl text-sm sm:text-base focus:ring-2 focus:ring-red-500 outline-none"
              type="password"
              placeholder={t.password}
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
            />

            <button
              onClick={handleReset}
              disabled={loading}
              className={`w-full min-h-[44px] rounded-xl font-bold text-white transition ${
                loading ? "bg-red-400" : "bg-red-600 hover:bg-red-700"
              }`}
            >
              {loading ? t.loading : t.forgotPassword}
            </button>

          </div>

          {/* FOOTER */}
          <div className="text-center mt-6">
            <button
              onClick={() => router.push("/auth/login")}
              className="text-blue-600 font-semibold hover:underline"
            >
              {t.login}
            </button>
          </div>

        </div>
      </div>
    </main>
  );
}