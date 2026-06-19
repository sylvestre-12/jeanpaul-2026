"use client";

import { ReactNode } from "react";

interface CardProps {
  title?: string;
  children: ReactNode;
  footer?: ReactNode;
}

export default function Card({ title, children, footer }: CardProps) {
  return (
    <div className="bg-white/80 backdrop-blur-md rounded-2xl shadow-md hover:shadow-lg transition p-5">

      {title && (
        <h3 className="text-lg md:text-xl font-bold mb-3 text-gray-800">
          {title}
        </h3>
      )}

      <div className="text-gray-600 text-sm md:text-base">
        {children}
      </div>

      {footer && (
        <div className="mt-4 border-t pt-3">
          {footer}
        </div>
      )}
    </div>
  );
}