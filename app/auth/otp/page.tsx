"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function OTPPage() {
  const router = useRouter();
  const [otp, setOtp] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  async function verify() {
    if (!otp.trim()) {
      setError("Please enter OTP");
      return;
    }

    setLoading(true);
    setError("");

    const userId = localStorage.getItem("userId");

    try {
      const res = await fetch("/api/auth/verify-otp", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId, otp }),
      });

      const data = await res.json();

      if (data.error) {
        setError(data.error);
        return;
      }

      if (!data.approved) {
        router.push("/notapproved");
      } else if (data.role === "ADMIN") {
        router.push("/admin/dashboard");
      } else {
        router.push("/user/dashboard");
      }
    } catch {
      setError("Something went wrong. Try again.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="min-h-screen w-full bg-gradient-to-br from-gray-100 to-gray-200 flex flex-col items-center px-4 py-6 sm:py-10">

      {/* CARD */}
      <div className="
        w-full max-w-md
        bg-white
        rounded-2xl
        shadow-lg
        p-5 sm:p-6
        mt-6 sm:mt-10
      ">

        {/* HEADER */}
        <div className="flex items-center justify-between mb-5">

          {/* BACK BUTTON (BLACK + STRONG) */}
          <button
            onClick={() => router.back()}
            className="
              min-h-[44px]
              px-3 py-2
              text-sm sm:text-base
              font-bold text-black
              border border-gray-400
              rounded-xl
              hover:bg-gray-100
              transition
            "
          >
            ← Back
          </button>

          <h1 className="text-base sm:text-xl font-extrabold text-gray-900 text-center flex-1">
            OTP Verification
          </h1>

          <div className="w-10" />
        </div>

        {/* INFO TEXT */}
        <p className="text-sm text-gray-600 text-center mb-4 leading-6">
          Enter the OTP sent to your account
        </p>

        {/* ERROR */}
        {error && (
          <div className="mb-3 text-sm text-red-700 bg-red-50 border border-red-200 p-2 rounded-lg text-center">
            {error}
          </div>
        )}

        {/* INPUT */}
        <input
          type="text"
          inputMode="numeric"
          maxLength={6}
          className="
            w-full
            p-3 sm:p-4
            text-center text-lg sm:text-xl tracking-widest
            border border-gray-300
            rounded-xl
            focus:outline-none focus:ring-2 focus:ring-blue-500
            min-h-[44px]
          "
          placeholder="Enter OTP"
          value={otp}
          onChange={(e) => setOtp(e.target.value)}
        />

        {/* BUTTON */}
        <button
          onClick={verify}
          disabled={loading}
          className={`
            w-full mt-4
            min-h-[44px]
            p-3 sm:p-4
            rounded-xl
            font-bold
            text-white
            transition
            focus:outline-none focus:ring-2 focus:ring-blue-400
            ${loading
              ? "bg-blue-300 cursor-not-allowed"
              : "bg-blue-600 hover:bg-blue-700"
            }
          `}
        >
          {loading ? "Verifying..." : "Verify OTP"}
        </button>

        {/* FOOTER */}
        <p className="text-center text-xs text-gray-400 mt-4">
          Secure login verification
        </p>

      </div>
    </main>
  );
}