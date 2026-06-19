"use client";

import { useRouter } from "next/navigation";
import { motion } from "framer-motion";
import { translations } from "@/i18n/translations";
import { useLanguage } from "@/i18n/LanguageProvider";
import { useState } from "react";

export default function HomePage() {
  const router = useRouter();
  const { lang, setLang } = useLanguage();
  const [open, setOpen] = useState(false);

  const t = translations[lang];

  return (
    <main className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-green-50">

      {/* NAVBAR */}
      <nav className="flex justify-between items-center px-4 md:px-8 py-3 max-w-7xl mx-auto">
        
        <h1 className="text-lg md:text-xl font-bold">
          🚦 Traffic System
        </h1>

        {/* RIGHT SIDE */}
        <div className="flex items-center gap-3 relative">

          {/* LANGUAGE BUTTON */}
          <div className="relative">
            <button
              onClick={() => setOpen(!open)}
              className="px-3 py-2 text-sm md:text-base border rounded-lg hover:bg-gray-100"
            >
              🌐 LANGUAGES
            </button>

            {/* DROPDOWN */}
            {open && (
              <div className="absolute right-0 mt-2 bg-white shadow-lg rounded-xl border w-44 z-50">

                {["EN", "FR", "RW"].map((l) => (
                  <button
                    key={l}
                    onClick={() => {
                      setLang(l as any);   // instant switch
                      setOpen(false);
                    }}
                    className={`w-full text-left px-4 py-2 text-sm hover:bg-gray-100 ${
                      lang === l ? "bg-blue-100 font-semibold" : ""
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

          {/* LOGIN */}
          <button
            onClick={() => router.push("/auth/login")}
            className="px-3 py-2 text-sm md:text-base border rounded-lg hover:bg-gray-100"
          >
            {t.login}
          </button>
        </div>
      </nav>

      {/* HERO */}
      <section className="text-center mt-12 px-4">

        <motion.h2
          initial={{ opacity: 0, y: -30 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-2xl md:text-4xl font-bold"
        >
          {t.title}
        </motion.h2>

        <motion.h3
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-lg md:text-xl text-blue-600 mt-2"
        >
          {t.subtitle}
        </motion.h3>

        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="mt-4 text-sm md:text-base text-gray-600 max-w-lg mx-auto"
        >
          {t.description}
        </motion.p>

        <motion.div
          initial={{ scale: 0.9 }}
          animate={{ scale: 1 }}
          className="mt-6 flex flex-col md:flex-row gap-3 justify-center"
        >
          <button
            onClick={() => router.push("/auth/signup")}
            className="bg-blue-600 text-white px-6 py-3 text-sm md:text-base rounded-xl hover:bg-blue-700"
          >
            🚀 {t.getStarted}
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            className="border px-6 py-3 text-sm md:text-base rounded-xl hover:bg-gray-100"
          >
            {t.login}
          </button>
        </motion.div>
      </section>

      {/* FEATURES */}
      <section className="mt-14 grid md:grid-cols-3 gap-4 px-4 max-w-5xl mx-auto">

        {[t.learn, t.test, t.track].map((item, i) => (
          <motion.div
            key={i}
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            className="bg-white p-4 rounded-xl shadow hover:shadow-md transition"
          >
            <h3 className="text-base md:text-lg font-semibold mb-2">
              {item}
            </h3>

            <p className="text-sm text-gray-600">
              {(t as any).featureDesc || "Learn traffic rules step by step"}
            </p>

          </motion.div>
        ))}
      </section>
    </main>
  );
}