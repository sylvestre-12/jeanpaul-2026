"use client";

import { useLanguage } from "@/i18n/LanguageProvider";

export default function LanguageSwitcher() {
  const { lang, setLang } = useLanguage();

  const languages = ["EN", "FR", "RW"] as const;

  return (
    <div
      className="
        flex flex-wrap
        items-center
        gap-2
        w-full sm:w-auto
      "
      role="group"
      aria-label="Language switcher"
    >
      {languages.map((l) => (
        <button
          key={l}
          onClick={() => setLang(l)}
          aria-pressed={lang === l}
          aria-label={`Switch language to ${l}`}
          className={`
            min-h-[44px]
            min-w-[44px]
            px-4 py-2

            text-sm sm:text-base
            font-semibold

            rounded-xl
            transition

            focus:outline-none focus:ring-2 focus:ring-offset-2

            ${
              lang === l
                ? "bg-blue-600 text-white shadow-md focus:ring-blue-400"
                : "border border-gray-300 text-gray-800 hover:bg-gray-100 focus:ring-gray-300"
            }
          `}
        >
          {l}
        </button>
      ))}
    </div>
  );
}