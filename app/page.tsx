"use client";

import { useRouter } from "next/navigation";
import { motion, useReducedMotion } from "framer-motion";
import { translations } from "@/i18n/translations";
import { useLanguage } from "@/i18n/LanguageProvider";
import { useState } from "react";

export default function HomePage() {
  const router = useRouter();
  const { lang, setLang } = useLanguage();
  const [open, setOpen] = useState(false);

  // Reduces animation for users who prefer less motion
  const shouldReduceMotion = useReducedMotion();

  const t = translations[lang];

  return (
    <main className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-green-50">

      {/* NAVBAR */}
      <nav className="sticky top-0 z-40 bg-white/80 backdrop-blur border-b">
        <div className="max-w-7xl mx-auto px-4 md:px-8 py-4 flex items-center justify-between">

          <h1 className="text-lg md:text-2xl font-bold text-gray-900">
            🚦 Traffic System
          </h1>

          <div className="flex items-center gap-2 md:gap-3 relative">

            {/* Language */}
            <div className="relative">
              <button
                aria-label="Select language"
                onClick={() => setOpen(!open)}
                className="
                  min-h-[44px]
                  px-3 md:px-4
                  text-sm md:text-base
                  border
                  rounded-xl
                  bg-white
                  hover:bg-gray-50
                  transition
                "
              >
                🌐 Language
              </button>

              {open && (
                <div className="absolute right-0 mt-2 w-44 rounded-xl border bg-white shadow-xl overflow-hidden z-50">
                  {["EN", "FR", "RW"].map((l) => (
                    <button
                      key={l}
                      onClick={() => {
                        setLang(l as any);
                        setOpen(false);
                      }}
                      className={`
                        w-full text-left px-4 py-3 text-sm
                        hover:bg-gray-100 transition
                        ${
                          lang === l
                            ? "bg-blue-100 font-semibold"
                            : ""
                        }
                      `}
                    >
                      {l === "EN" && "English"}
                      {l === "FR" && "Français"}
                      {l === "RW" && "Kinyarwanda"}
                    </button>
                  ))}
                </div>
              )}
            </div>

            {/* Login */}
            <button
              onClick={() => router.push("/auth/login")}
              className="
                min-h-[44px]
                px-4
                text-sm md:text-base
                border
                rounded-xl
                hover:bg-gray-50
                transition
              "
            >
              {t.login}
            </button>
          </div>
        </div>
      </nav>

      {/* HERO */}
      <section className="max-w-5xl mx-auto px-4 pt-12 md:pt-20 text-center">

        <motion.h2
          initial={
            shouldReduceMotion
              ? false
              : { opacity: 0, y: -20 }
          }
          animate={
            shouldReduceMotion
              ? {}
              : { opacity: 1, y: 0 }
          }
          transition={{ duration: 0.5 }}
          className="
            text-3xl
            sm:text-4xl
            md:text-5xl
            font-bold
            leading-tight
            text-gray-900
          "
        >
          {t.title}
        </motion.h2>

        <motion.h3
          initial={
            shouldReduceMotion
              ? false
              : { opacity: 0, y: 15 }
          }
          animate={
            shouldReduceMotion
              ? {}
              : { opacity: 1, y: 0 }
          }
          transition={{ delay: 0.1 }}
          className="
            mt-4
            text-lg
            md:text-2xl
            text-blue-600
            font-medium
          "
        >
          {t.subtitle}
        </motion.h3>

        <motion.p
          initial={
            shouldReduceMotion
              ? false
              : { opacity: 0 }
          }
          animate={
            shouldReduceMotion
              ? {}
              : { opacity: 1 }
          }
          transition={{ delay: 0.2 }}
          className="
            mt-6
            max-w-2xl
            mx-auto
            text-base
            md:text-lg
            leading-8
            text-gray-600
          "
        >
          {t.description}
        </motion.p>

        <motion.div
          initial={
            shouldReduceMotion
              ? false
              : { opacity: 0, y: 10 }
          }
          animate={
            shouldReduceMotion
              ? {}
              : { opacity: 1, y: 0 }
          }
          transition={{ delay: 0.3 }}
          className="
            mt-8
            flex
            flex-col
            sm:flex-row
            justify-center
            gap-4
          "
        >
          <button
            onClick={() => router.push("/auth/signup")}
            className="
              min-h-[50px]
              px-8
              rounded-xl
              bg-blue-600
              text-white
              font-medium
              hover:bg-blue-700
              transition
              shadow-md
            "
          >
            🚀 {t.getStarted}
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            className="
              min-h-[50px]
              px-8
              rounded-xl
              border
              font-medium
              hover:bg-gray-100
              transition
            "
          >
            {t.login}
          </button>
        </motion.div>
      </section>

      {/* FEATURES */}
      <section className="max-w-6xl mx-auto px-4 py-14 md:py-20">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">

          {[t.learn, t.test, t.track].map((item, i) => (
            <motion.div
              key={i}
              initial={
                shouldReduceMotion
                  ? false
                  : { opacity: 0, y: 20 }
              }
              whileInView={
                shouldReduceMotion
                  ? {}
                  : { opacity: 1, y: 0 }
              }
              viewport={{ once: true }}
              transition={{ delay: i * 0.1 }}
              className="
                bg-white
                rounded-2xl
                p-6
                shadow-sm
                border
                hover:shadow-lg
                transition
              "
            >
              <h3 className="text-lg md:text-xl font-semibold text-gray-900 mb-3">
                {item}
              </h3>

              <p className="text-gray-600 leading-7">
                {(t as any).featureDesc ||
                  "Learn traffic rules step by step."}
              </p>
            </motion.div>
          ))}
        </div>
      </section>
    </main>
  );
}