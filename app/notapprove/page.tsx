"use client";

import { useRouter } from "next/navigation";

export default function NotApproved() {
  const router = useRouter();

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 px-4">

      {/* CARD */}
      <div className="w-full max-w-sm sm:max-w-md bg-white rounded-2xl shadow-lg p-6 text-center">

        {/* ICON */}
        <div className="text-5xl mb-4">⏳</div>

        {/* TITLE */}
        <h1 className="text-lg sm:text-2xl font-bold text-gray-800 mb-2">
          Account Not Approved
        </h1>

        {/* MESSAGE */}
        <p className="text-gray-600 text-sm sm:text-base mb-6 leading-relaxed">
          Your account is still waiting for admin approval.
          <br />
          You will be able to access the system once it is approved.
        </p>

        {/* STATUS BADGE */}
        <div className="inline-block px-4 py-2 text-sm rounded-full bg-yellow-100 text-yellow-700 font-semibold mb-6">
          Pending Approval
        </div>

        {/* BACK BUTTON */}
        <button
          onClick={() => router.push("/auth/login")}
          className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-xl transition"
        >
          ← Back to Login
        </button>

        {/* FOOTER NOTE */}
        <p className="text-xs text-gray-400 mt-4">
          Please contact support if this takes too long
        </p>

      </div>
    </div>
  );
}