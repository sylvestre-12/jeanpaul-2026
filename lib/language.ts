export const LANG_KEY = "app_lang";

export function getStoredLanguage(): string {
  if (typeof window === "undefined") return "EN";

  const lang = localStorage.getItem(LANG_KEY);

  if (lang === "EN" || lang === "FR" || lang === "RW") {
    return lang;
  }

  return "EN";
}

export function setStoredLanguage(lang: "EN" | "FR" | "RW") {
  if (typeof window === "undefined") return;

  localStorage.setItem(LANG_KEY, lang);

  document.cookie = `lang=${lang}; path=/; max-age=31536000`;
}