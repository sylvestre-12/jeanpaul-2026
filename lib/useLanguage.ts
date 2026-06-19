"use client";

import { useState, useEffect } from "react";

type Lang = "EN" | "FR" | "RW";

export function useLanguage() {
  const [lang, setLang] = useState<Lang>("EN");

  useEffect(() => {
    const saved = localStorage.getItem("lang") as Lang | null;

    if (saved && ["EN", "FR", "RW"].includes(saved)) {
      setLang(saved);
    }
  }, []);

  function changeLanguage(l: Lang) {
    const safeLang = l.toUpperCase() as Lang;

    setLang(safeLang);
    localStorage.setItem("lang", safeLang);
  }

  return { lang, changeLanguage };
}