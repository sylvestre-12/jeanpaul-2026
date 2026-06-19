import { translations } from "@/i18n/translations";

export function t(lang: "EN" | "FR" | "RW") {
  return translations[lang];
}