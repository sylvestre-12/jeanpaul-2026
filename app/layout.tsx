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
        {/* FIX MOBILE VIEWPORT */}
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1, viewport-fit=cover"
        />
      </head>

      <body
        className="
          min-h-dvh
          w-full
          bg-gray-50
          text-gray-900
          antialiased
          overflow-x-hidden
          flex flex-col
        "
      >
        <LanguageProvider>
          <div className="flex flex-col flex-1 w-full min-h-dvh">
            {children}
          </div>
        </LanguageProvider>
      </body>
    </html>
  );
}