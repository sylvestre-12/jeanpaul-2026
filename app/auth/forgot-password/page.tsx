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
        alert(
          safeLang === "FR"
            ? "Mot de passe réinitialisé avec succès"
            : safeLang === "RW"
            ? "Ijambo ry'ibanga ryahinduwe neza"
            : "Password reset successful"
        );

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
    <main className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 px-3 sm:px-4">

      {/* CARD */}
      <div className="w-full max-w-sm sm:max-w-md bg-white rounded-2xl shadow-xl p-5 sm:p-6">

        {/* HEADER */}
        <div className="flex justify-between items-center mb-6">

          {/* BACK BUTTON */}
          <button
            onClick={() => router.push("/auth/login")}
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
                      changeLanguage(l);
                      setOpen(false);
                    }}
                    className={`w-full text-left px-4 py-2 text-sm hover:bg-gray-100 ${
                      safeLang === l ? "bg-blue-50 font-semibold" : ""
                    }`}
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
          {safeLang === "FR"
            ? "Mot de passe oublié"
            : safeLang === "RW"
            ? "Wibagiwe ijambo ry'ibanga"
            : "Forgot Password"}
        </h1>

        {/* FORM */}
        <div className="space-y-4">

          <input
            className="w-full p-3 sm:p-4 border rounded-xl focus:ring-2 focus:ring-red-500 outline-none text-sm sm:text-base"
            placeholder={
              safeLang === "FR"
                ? "Numéro de téléphone"
                : safeLang === "RW"
                ? "Inomero ya telefone"
                : "Phone number"
            }
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
          />

          <input
            className="w-full p-3 sm:p-4 border rounded-xl focus:ring-2 focus:ring-red-500 outline-none text-sm sm:text-base"
            type="password"
            placeholder={
              safeLang === "FR"
                ? "Nouveau mot de passe"
                : safeLang === "RW"
                ? "Ijambo ry'ibanga rishya"
                : "New password"
            }
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
          />

          <button
            onClick={handleReset}
            disabled={loading}
            className={`w-full p-3 sm:p-4 rounded-xl font-semibold text-white transition
              ${loading ? "bg-red-400" : "bg-red-600 hover:bg-red-700"}`}
          >
            {loading
              ? "Processing..."
              : safeLang === "FR"
              ? "Réinitialiser"
              : safeLang === "RW"
              ? "Hindura"
              : "Reset Password"}
          </button>
        </div>

        {/* FOOTER LINK */}
        <div className="text-center mt-5 text-sm">
          <button
            onClick={() => router.push("/auth/login")}
            className="text-blue-600 hover:underline"
          >
            {safeLang === "FR"
              ? "Retour connexion"
              : safeLang === "RW"
              ? "Subira kwinjira"
              : "Back to login"}
          </button>
        </div>

      </div>
    </main>
  );
}