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

const LanguageContext = createContext<ContextType | undefined>(
  undefined
);

export function LanguageProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [lang, setLangState] = useState<Lang>("EN");
  const [ready, setReady] = useState(false);

  // Load language safely (client-only + SSR safe)
  useEffect(() => {
    try {
      const stored =
        typeof window !== "undefined"
          ? localStorage.getItem("app_lang") ||
            localStorage.getItem(LANG_KEY) ||
            getStoredLanguage()
          : "EN";

      if (stored === "EN" || stored === "FR" || stored === "RW") {
        setLangState(stored);
      } else {
        setLangState("EN");
      }
    } catch (error) {
      console.error("Language load error:", error);
      setLangState("EN");
    } finally {
      setReady(true);
    }
  }, []);

  const setLang = useCallback(async (l: Lang) => {
    try {
      setLangState(l);

      setStoredLanguage(l);

      if (typeof window !== "undefined") {
        localStorage.setItem("app_lang", l);
        localStorage.setItem(LANG_KEY, l);
      }

      const userId =
        typeof window !== "undefined"
          ? localStorage.getItem("userId")
          : null;

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

  // Instead of returning null (bad UX on mobile), show minimal fallback UI
  if (!ready) {
    return (
      <div className="flex items-center justify-center min-h-screen text-sm text-gray-500 px-4 text-center">
        Loading application...
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
    throw new Error(
      "useLanguage must be used inside LanguageProvider"
    );
  }

  return context;
}