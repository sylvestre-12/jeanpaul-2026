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
  loading,
  className,
  ...props
}: ButtonProps) {
  return (
    <button
      {...props}
      disabled={loading || props.disabled}
      className={clsx(
        "rounded-xl font-semibold transition focus:outline-none focus:ring-2",
        
        // SIZE
        {
          "px-3 py-2 text-sm": size === "sm",
          "px-5 py-3 text-base": size === "md",
          "px-6 py-4 text-lg": size === "lg",
        },

        // VARIANT
        {
          "bg-blue-600 text-white hover:bg-blue-700": variant === "primary",
          "bg-gray-200 hover:bg-gray-300": variant === "secondary",
          "bg-red-500 text-white hover:bg-red-600": variant === "danger",
          "border hover:bg-gray-100": variant === "outline",
        },

        className
      )}
    >
      {loading ? "Loading..." : children}
    </button>
  );
}