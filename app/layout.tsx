import "./globals.css";
import { LanguageProvider } from "@/i18n/LanguageProvider";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className="min-h-screen flex flex-col bg-gray-50 text-gray-900 antialiased">
        
        {/* 🌍 GLOBAL LANGUAGE PROVIDER */}
        <LanguageProvider>
          {children}
        </LanguageProvider>

      </body>
    </html>
  );
}