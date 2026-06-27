import "./globals.css";
import { LanguageProvider } from "@/i18n/LanguageProvider";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        {/* Mobile responsiveness (important) */}
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </head>

      <body
        className="
          min-h-screen
          flex flex-col
          bg-gray-50
          text-gray-900
          antialiased
          overflow-x-hidden
          leading-relaxed
        "
      >
        {/* GLOBAL APP WRAPPER */}
        <LanguageProvider>
          <div className="flex-1 w-full">
            {children}
          </div>
        </LanguageProvider>
      </body>
    </html>
  );
}