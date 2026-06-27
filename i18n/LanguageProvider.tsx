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

  // ✅ GLOBAL EVENT (this is the KEY FIX)
  const broadcastLanguageChange = (value: Lang) => {
    if (typeof window !== "undefined") {
      window.dispatchEvent(
        new CustomEvent("lang-change", { detail: value })
      );
    }
  };

  useEffect(() => {
    try {
      const stored =
        localStorage.getItem("app_lang") ||
        localStorage.getItem(LANG_KEY) ||
        getStoredLanguage();

      const normalized = (stored || "EN").toUpperCase();

      if (normalized === "EN" || normalized === "FR" || normalized === "RW") {
        setLangState(normalized as Lang);
      } else {
        setLangState("EN");
      }
    } catch {
      setLangState("EN");
    } finally {
      setReady(true);
    }
  }, []);

  const setLang = useCallback(async (l: Lang) => {
    try {
      const value = l.toUpperCase() as Lang;

      setLangState(value);

      setStoredLanguage(value);

      localStorage.setItem("app_lang", value);
      localStorage.setItem(LANG_KEY, value);

      // 🔥 THIS MAKES ALL COMPONENTS REACT INSTANTLY
      broadcastLanguageChange(value);

      const userId = localStorage.getItem("userId");

      if (userId) {
        await fetch("/api/user/language", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            userId,
            language: value,
          }),
        });
      }
    } catch (err) {
      console.error("Language save failed:", err);
    }
  }, []);

  if (!ready) {
    return (
      <div className="min-h-screen w-full flex items-center justify-center">
        Loading...
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