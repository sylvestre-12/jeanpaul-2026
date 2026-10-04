"use client";

import { useRouter } from "next/navigation";

export default function NotApproved() {
  const router = useRouter();

  return (
    <main className="min-h-screen w-full bg-gradient-to-br from-gray-100 to-gray-200 flex flex-col items-center px-4 py-6 sm:py-10">

      {/* CARD */}
      <div className="
        w-full max-w-md
        bg-white
        rounded-2xl
        shadow-lg
        p-6 sm:p-7
        mt-6 sm:mt-10
        text-center
      ">

        {/* ICON */}
        <div className="text-5xl sm:text-6xl mb-4">
          ⏳
        </div>

        {/* TITLE */}
        <h1 className="text-lg sm:text-2xl font-extrabold text-gray-900 mb-2">
          Account Not Approved
        </h1>

        {/* MESSAGE */}
        <p className="text-sm sm:text-base text-gray-600 mb-6 leading-7">
          Your account is still waiting for admin approval.
          <br />
          You will be able to access the system once it is approved.
        </p>

        {/* STATUS BADGE */}
        <div className="
          inline-block
          px-4 py-2
          text-sm
          rounded-full
          bg-yellow-100
          text-yellow-700
          font-semibold
          mb-6
        ">
          Pending Approval
        </div>

        {/* BACK BUTTON */}
        <button
          onClick={() => router.push("/auth/login")}
          className="
            w-full
            min-h-[44px]
            bg-blue-600 text-white
            font-bold
            py-3
            rounded-xl
            hover:bg-blue-700
            transition
            focus:outline-none focus:ring-2 focus:ring-blue-400
          "
        >
          ← Back to Login
        </button>

        {/* FOOTER */}
        <p className="text-xs text-gray-400 mt-5">
          Please contact support if this takes too long
        </p>

      </div>
    </main>
  );
}