"use client";

import { useLanguage } from "@/i18n/LanguageProvider";

export default function LanguageSwitcher() {
  const { lang, setLang } = useLanguage();

  return (
    <div className="flex gap-2">
      {["EN", "FR", "RW"].map((l) => (
        <button
          key={l}
          onClick={() => setLang(l as any)}
          className={`px-3 py-1 rounded-lg text-sm md:text-base transition ${
            lang === l
              ? "bg-blue-600 text-white shadow"
              : "border hover:bg-gray-100"
          }`}
        >
          {l}
        </button>
      ))}
    </div>
  );
}