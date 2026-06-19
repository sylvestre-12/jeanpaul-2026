"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { useLanguage } from "@/i18n/LanguageProvider";
import { translations } from "@/i18n/translations";

export default function UserDashboard() {
  const router = useRouter();
  const { lang, setLang } = useLanguage();

  const t = translations[lang as "EN" | "FR" | "RW"] || translations.EN;

  const [name, setName] = useState<string | null>(null);
  const [phone, setPhone] = useState<string | null>(null);

  useEffect(() => {
    const savedLang =
      localStorage.getItem("app_lang") ||
      localStorage.getItem("language") ||
      localStorage.getItem("lang");

    if (savedLang) setLang(savedLang as any);

    setName(localStorage.getItem("userName") || "User");
    setPhone(localStorage.getItem("userPhone") || "");
  }, [setLang]);

  const Card = ({ title, desc, color, onClick, icon }: any) => (
    <button
      onClick={onClick}
      className={`w-full text-left p-4 sm:p-5 rounded-xl sm:rounded-2xl shadow-md transition transform hover:scale-[1.02] active:scale-95 text-white ${color}`}
    >
      <div className="text-2xl sm:text-3xl mb-2">{icon}</div>
      <div className="text-base sm:text-lg font-bold">{title}</div>
      <div className="text-xs sm:text-sm opacity-90">{desc}</div>
    </button>
  );

  return (
    <div className="min-h-screen bg-gray-100 p-3 sm:p-6">

      {/* TOP BAR */}
      <div className="flex justify-between items-center mb-4">
        <button
          onClick={() => router.push("/")}
          className="px-3 py-1 text-sm bg-white rounded-lg shadow hover:bg-gray-50"
        >
          ← Back
        </button>

        <div className="text-sm text-gray-600 font-medium">
          🌍 {lang}
        </div>
      </div>

      {/* HEADER */}
      <div className="bg-white rounded-xl sm:rounded-2xl shadow p-4 sm:p-6 mb-6">
        <h1 className="text-xl sm:text-3xl font-bold">
          👋 {t.welcome}:{" "}
          <span className="text-blue-600">{name ?? t.loading}</span>
        </h1>

        <p className="text-gray-600 mt-1 text-sm sm:text-base">
          📱 {t.phone}: {phone ?? t.loading}
        </p>

        <div className="mt-2 text-xs sm:text-sm text-gray-500">
          {t.dashboardMessage}
        </div>
      </div>

      {/* GRID */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-5">

        <Card
          title={t.startExam}
          desc={t.startExamDesc}
          icon="📘"
          color="bg-blue-600 hover:bg-blue-700"
          onClick={() => router.push("/user/test")}
        />

        <Card
          title={t.readQA}
          desc={t.readQADesc}
          icon="📊"
          color="bg-green-600 hover:bg-green-700"
          onClick={() => router.push("/user/questions")}
        />

        <Card
          title={t.examHistory}
          desc={t.examHistoryDesc}
          icon="📜"
          color="bg-purple-600 hover:bg-purple-700"
          onClick={() => router.push("/user/history")}
        />

        <Card
          title={t.downloadReports}
          desc={t.downloadReportsDesc}
          icon="📥"
          color="bg-orange-600 hover:bg-orange-700"
          onClick={() => router.push("/user/download")}
        />

      </div>

      {/* FOOTER */}
      <div className="text-center text-gray-500 text-xs sm:text-sm mt-10">
        © {new Date().getFullYear()} {t.examSystem} • {t.allRightsReserved}
      </div>
    </div>
  );
}