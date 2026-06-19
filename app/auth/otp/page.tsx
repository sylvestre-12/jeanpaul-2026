"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function OTPPage() {
  const router = useRouter();
  const [otp, setOtp] = useState("");
  const [loading, setLoading] = useState(false);

  async function verify() {
    if (!otp.trim()) return alert("Please enter OTP");

    setLoading(true);

    const userId = localStorage.getItem("userId");

    try {
      const res = await fetch("/api/auth/verify-otp", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId, otp }),
      });

      const data = await res.json();

      if (data.error) {
        alert(data.error);
        setLoading(false);
        return;
      }

      if (!data.approved) {
        router.push("/notapproved");
      } else if (data.role === "ADMIN") {
        router.push("/admin/dashboard");
      } else {
        router.push("/user/dashboard");
      }
    } catch (err) {
      alert("Something went wrong");
    }

    setLoading(false);
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200 p-3 sm:p-4">

      {/* CARD */}
      <div className="w-full max-w-sm sm:max-w-md bg-white rounded-2xl shadow-lg p-5 sm:p-6">

        {/* HEADER */}
        <div className="flex items-center justify-between mb-6">

          {/* BACK BUTTON */}
          <button
            onClick={() => router.back()}
            className="text-sm sm:text-base px-3 py-1 rounded-lg border hover:bg-gray-100 transition"
          >
            ← Back
          </button>

          <h1 className="text-base sm:text-xl font-bold text-gray-800">
            OTP Verification
          </h1>

          <div className="w-12" /> {/* spacer */}
        </div>

        {/* INFO TEXT */}
        <p className="text-xs sm:text-sm text-gray-500 mb-4 text-center">
          Enter the OTP sent to your account
        </p>

        {/* INPUT */}
        <input
          className="w-full p-3 sm:p-4 text-center text-lg tracking-widest border rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500"
          placeholder="Enter OTP"
          value={otp}
          onChange={(e) => setOtp(e.target.value)}
        />

        {/* BUTTON */}
        <button
          onClick={verify}
          disabled={loading}
          className={`w-full mt-4 p-3 sm:p-4 rounded-xl font-semibold transition text-white
            ${loading ? "bg-blue-300" : "bg-blue-600 hover:bg-blue-700"}`}
        >
          {loading ? "Verifying..." : "Verify OTP"}
        </button>

        {/* FOOTER */}
        <p className="text-center text-xs text-gray-400 mt-4">
          Secure login verification
        </p>

      </div>
    </div>
  );
}