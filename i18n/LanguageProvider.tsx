"use client";

import React, {
  createContext,
  useContext,
  useEffect,
  useState,
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

const LanguageContext = createContext<ContextType>({
  lang: "EN",
  setLang: async () => {},
});

export function LanguageProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const [lang, setLangState] = useState<Lang>("EN");
  const [ready, setReady] = useState(false);

  useEffect(() => {
    const stored =
      localStorage.getItem("app_lang") ||
      localStorage.getItem(LANG_KEY) ||
      getStoredLanguage();

    if (
      stored === "EN" ||
      stored === "FR" ||
      stored === "RW"
    ) {
      setLangState(stored);
    } else {
      setLangState("EN");
    }

    setReady(true);
  }, []);

  const setLang = async (l: Lang) => {
    setLangState(l);

    setStoredLanguage(l);
    localStorage.setItem("app_lang", l);
    localStorage.setItem(LANG_KEY, l);

    const userId = localStorage.getItem("userId");

    if (userId) {
      try {
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
      } catch (err) {
        console.error("Language save failed:", err);
      }
    }
  };

  if (!ready) {
    return null;
  }

  return (
    <LanguageContext.Provider
      value={{
        lang,
        setLang,
      }}
    >
      {children}
    </LanguageContext.Provider>
  );
}

export const useLanguage = () => useContext(LanguageContext);