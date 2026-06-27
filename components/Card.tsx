"use client";

import { ReactNode } from "react";
import clsx from "clsx";

interface CardProps {
  title?: string;
  children: ReactNode;
  footer?: ReactNode;
  className?: string;
}

export default function Card({
  title,
  children,
  footer,
  className,
}: CardProps) {
  return (
    <div
      className={clsx(
        // Base (mobile friendly + eye comfort)
        "bg-white/90 backdrop-blur-md",
        "rounded-2xl shadow-sm hover:shadow-md transition",
        "p-4 sm:p-5 md:p-6",
        "border border-gray-100",
        "text-gray-900",

        className
      )}
    >
      {/* TITLE */}
      {title && (
        <h3
          className={clsx(
            "font-semibold text-gray-900",
            "mb-3",
            "text-base sm:text-lg md:text-xl",
            "leading-snug"
          )}
        >
          {title}
        </h3>
      )}

      {/* CONTENT */}
      <div
        className={clsx(
          "text-gray-700",
          "text-sm sm:text-base",
          "leading-6 sm:leading-7"
        )}
      >
        {children}
      </div>

      {/* FOOTER */}
      {footer && (
        <div
          className={clsx(
            "mt-4 pt-3 border-t border-gray-100",
            "text-sm text-gray-600"
          )}
        >
          {footer}
        </div>
      )}
    </div>
  );
}