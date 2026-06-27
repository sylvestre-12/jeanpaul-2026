"use client";

import { ButtonHTMLAttributes } from "react";
import clsx from "clsx";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "danger" | "outline";
  size?: "sm" | "md" | "lg";
  loading?: boolean;
}

export default function Button({
  children,
  variant = "primary",
  size = "md",
  loading = false,
  className,
  disabled,
  ...props
}: ButtonProps) {
  const isDisabled = loading || disabled;

  return (
    <button
      {...props}
      disabled={isDisabled}
      aria-busy={loading}
      className={clsx(
        // BASE (mobile-first + accessibility + eye comfort)
        "w-full sm:w-auto",
        "rounded-xl font-semibold transition",
        "focus:outline-none focus:ring-2 focus:ring-offset-2",
        "disabled:opacity-50 disabled:cursor-not-allowed",
        "min-h-[44px]",
        "flex items-center justify-center gap-2",
        "whitespace-nowrap",

        // SIZE (touch-friendly)
        {
          "px-3 py-2 text-sm": size === "sm",
          "px-5 py-3 text-base": size === "md",
          "px-6 py-4 text-lg": size === "lg",
        },

        // VARIANTS (better contrast for eye comfort)
        {
          "bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-400":
            variant === "primary",

          "bg-gray-200 text-gray-900 hover:bg-gray-300 focus:ring-gray-400":
            variant === "secondary",

          "bg-red-500 text-white hover:bg-red-600 focus:ring-red-400":
            variant === "danger",

          "border border-gray-300 text-gray-800 hover:bg-gray-100 focus:ring-gray-300":
            variant === "outline",
        },

        className
      )}
    >
      {loading ? (
        <span className="flex items-center gap-2 text-sm sm:text-base">
          <span className="animate-spin h-4 w-4 border-2 border-white border-t-transparent rounded-full" />
          Loading...
        </span>
      ) : (
        children
      )}
    </button>
  );
}