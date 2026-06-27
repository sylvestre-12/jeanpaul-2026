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
        // BASE CARD (mobile-first + readable + soft UI)
        "w-full",
        "bg-white/95 backdrop-blur-md",
        "rounded-2xl shadow-sm hover:shadow-md transition",

        // SPACING (VERY IMPORTANT for mobile eyes)
        "p-5 sm:p-6 md:p-7",

        // BORDER (soft, not harsh)
        "border border-gray-100",

        // TEXT BASE
        "text-gray-900",

        className
      )}
    >
      {/* TITLE */}
      {title && (
        <h3
          className="
            mb-3
            text-lg sm:text-xl md:text-2xl
            font-bold
            text-gray-900
            leading-snug
          "
        >
          {title}
        </h3>
      )}

      {/* CONTENT */}
      <div
        className="
          text-gray-700
          text-sm sm:text-base md:text-[15px]
          leading-7 sm:leading-8
          tracking-wide
        "
      >
        {children}
      </div>

      {/* FOOTER */}
      {footer && (
        <div
          className="
            mt-5 pt-4
            border-t border-gray-100
            text-sm text-gray-600
          "
        >
          {footer}
        </div>
      )}
    </div>
  );
}