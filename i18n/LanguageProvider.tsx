"use client";

import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
} from "react";

import {
  getStoredLanguage,
  setStoredLanguage,
  LANG_KEY,
} from "@/lib/language";

type Lang = "EN" | "FR" | "RW";

type ContextType = {
  lang: Lang;
  setLang: (l: Lang) => Promise<void>;
};

const LanguageContext = createContext<ContextType | undefined>(undefined);

export function LanguageProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [lang, setLangState] = useState<Lang>("EN");
  const [ready, setReady] = useState(false);

  // SAFE INIT (no SSR crash)
  useEffect(() => {
    try {
      const stored =
        localStorage.getItem("app_lang") ||
        localStorage.getItem(LANG_KEY) ||
        getStoredLanguage();

      if (stored === "EN" || stored === "FR" || stored === "RW") {
        setLangState(stored);
      } else {
        setLangState("EN");
      }
    } catch (err) {
      console.error("Language load error:", err);
      setLangState("EN");
    } finally {
      setReady(true);
    }
  }, []);

  // SAFE SET LANGUAGE
  const setLang = useCallback(async (l: Lang) => {
    try {
      setLangState(l);

      setStoredLanguage(l);

      localStorage.setItem("app_lang", l);
      localStorage.setItem(LANG_KEY, l);

      const userId = localStorage.getItem("userId");

      if (userId) {
        await fetch("/api/user/language", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            userId,
            language: l,
          }),
        });
      }
    } catch (err) {
      console.error("Language save failed:", err);
    }
  }, []);

  // IMPORTANT: NEVER BLOCK FULL SCREEN (mobile fix)
  if (!ready) {
    return (
      <div className="min-h-screen w-full flex flex-col items-center justify-center px-4 text-center">
        <div className="text-gray-500 text-sm sm:text-base font-medium animate-pulse">
          Loading application...
        </div>
      </div>
    );
  }

  return (
    <LanguageContext.Provider value={{ lang, setLang }}>
      {children}
    </LanguageContext.Provider>
  );
}

export function useLanguage() {
  const context = useContext(LanguageContext);

  if (!context) {
    throw new Error("useLanguage must be used inside LanguageProvider");
  }

  return context;
}