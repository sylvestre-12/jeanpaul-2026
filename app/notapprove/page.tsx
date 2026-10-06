
"use client";

import { useRouter } from "next/navigation";

export default function NotApproved() {
  const router = useRouter();

  // Support phone number
  const phoneNumber = "0722807435";

  // WhatsApp uses the international format without +
  const whatsappNumber = "250722807435";

  const whatsappMessage =
    "Thank you for using our system. Our support team is available to assist you with any questions or access requirements.";

  const handleCall = () => {
    window.location.href = `tel:${phoneNumber}`;
  };

  const handleWhatsApp = () => {
    const whatsappUrl = `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(
      whatsappMessage
    )}`;

    window.location.href = whatsappUrl;
  };

  return (
    <main className="min-h-screen w-full bg-gradient-to-br from-gray-100 to-gray-200 flex flex-col items-center px-4 py-6 sm:py-10">

      {/* CARD */}
      <div
        className="
          w-full max-w-md
          bg-white
          rounded-2xl
          shadow-lg
          p-6 sm:p-7
          mt-6 sm:mt-10
          text-center
        "
      >

        {/* ICON */}
        <div className="text-5xl sm:text-6xl mb-4">
          ⏳
        </div>

        {/* TITLE */}
        <h1 className="text-lg sm:text-2xl font-extrabold text-gray-900 mb-2">
          Account Not Approved
        </h1>

        {/* MESSAGE */}
        <p className="text-sm sm:text-base text-gray-600 mb-5 leading-7">
          Your account is currently waiting for administrator approval.
          <br />
          You will be able to access the system once your account has been
          approved.
        </p>

        {/* STATUS BADGE */}
        <div
          className="
            inline-block
            px-4 py-2
            text-sm
            rounded-full
            bg-yellow-100
            text-yellow-700
            font-semibold
            mb-6
          "
        >
          Pending Approval
        </div>

        {/* SUPPORT SECTION */}
        <div
          className="
            border border-gray-200
            bg-gray-50
            rounded-2xl
            p-5
            mb-6
          "
        >

          <h2 className="text-lg font-bold text-gray-900 mb-2">
            Need Assistance?
          </h2>

          <p className="text-sm text-gray-600 leading-6 mb-4">
            If you need assistance with your account or would like to get
            access to our available plans, please contact our support team.
          </p>

          {/* PHONE */}
          <button
            type="button"
            onClick={handleCall}
            className="
              w-full
              min-h-[46px]
              bg-green-600
              text-white
              font-bold
              py-3
              px-4
              rounded-xl
              hover:bg-green-700
              transition
              focus:outline-none
              focus:ring-2
              focus:ring-green-400
              mb-4
            "
          >
            📞 Call Support: 0722 807 435
          </button>

          {/* PLANS */}
          <div className="mb-4">

            <h3 className="text-sm font-bold text-gray-800 mb-3">
              Available Access Plans & Payments
            </h3>

            <div className="grid grid-cols-3 gap-2">

              {/* ONE DAY */}
              <div
                className="
                  bg-white
                  border border-gray-200
                  rounded-xl
                  p-3
                "
              >
                <p className="text-xs text-gray-500 mb-1">
                  One Day
                </p>

                <p className="text-sm sm:text-base font-extrabold text-gray-900">
                  3,500 FR
                </p>
              </div>

              {/* ONE WEEK */}
              <div
                className="
                  bg-white
                  border border-gray-200
                  rounded-xl
                  p-3
                "
              >
                <p className="text-xs text-gray-500 mb-1">
                  One Week
                </p>

                <p className="text-sm sm:text-base font-extrabold text-gray-900">
                  5,700 FR
                </p>
              </div>

              {/* ONE MONTH */}
              <div
                className="
                  bg-white
                  border border-gray-200
                  rounded-xl
                  p-3
                "
              >
                <p className="text-xs text-gray-500 mb-1">
                  One Month
                </p>

                <p className="text-sm sm:text-base font-extrabold text-gray-900">
                  9,900 FR
                </p>
              </div>

            </div>
          </div>

          {/* WHATSAPP */}
        
<button
  type="button"
  onClick={handleWhatsApp}
  className="
    w-full
    min-h-[46px]
    bg-green-600
    text-white
    font-bold
    py-3
    px-4
    rounded-xl
    hover:bg-green-700
    transition
    focus:outline-none
    focus:ring-2
    focus:ring-green-400
    flex
    items-center
    justify-center
    gap-2
  "
>
  {/* WhatsApp Logo */}
  <svg
    xmlns="http://www.w3.org/2000/svg"
    viewBox="0 0 24 24"
    className="w-7 h-7"
    fill="currentColor"
    aria-hidden="true"
  >
    <path d="M12.04 2C6.52 2 2.04 6.48 2.04 12c0 1.77.46 3.5 1.33 5.02L2 22l5.14-1.35A9.96 9.96 0 0 0 12.04 22C17.56 22 22 17.52 22 12S17.56 2 12.04 2Zm0 18.2c-1.56 0-3.09-.42-4.43-1.22l-.32-.19-3.05.8.82-2.97-.21-.33A8.2 8.2 0 1 1 12.04 20.2Zm4.49-6.15c-.25-.13-1.48-.73-1.71-.81-.23-.08-.4-.13-.57.13-.17.25-.65.81-.8.98-.15.17-.29.19-.54.06-.25-.13-1.05-.39-2-1.24-.74-.66-1.24-1.47-1.39-1.72-.15-.25-.02-.39.11-.52.12-.12.25-.29.38-.44.13-.15.17-.25.25-.42.08-.17.04-.31-.02-.44-.06-.13-.57-1.37-.78-1.87-.21-.5-.42-.43-.57-.44h-.49c-.17 0-.44.06-.67.31-.23.25-.88.86-.88 2.1s.9 2.43 1.02 2.6c.13.17 1.77 2.7 4.29 3.79.6.26 1.07.42 1.44.54.61.19 1.17.16 1.61.1.49-.07 1.48-.61 1.69-1.2.21-.59.21-1.1.15-1.2-.06-.1-.23-.16-.48-.29Z" />
  </svg>

  <span className="text-base sm:text-lg">
    Message Via WhatsApp
  </span>
</button>


        </div>

        {/* BACK TO LOGIN */}
        <button
          type="button"
          onClick={() => router.push("/auth/login")}
          className="
            w-full
            min-h-[44px]
            bg-gray-800
            text-white
            font-bold
            py-3
            rounded-xl
            hover:bg-gray-900
            transition
            focus:outline-none
            focus:ring-2
            focus:ring-gray-400
          "
        >
          ← Back to Login
        </button>

        {/* FOOTER */}
        <p className="text-xs text-gray-400 mt-5 leading-5">
          Thank you for using our system. Our support team is available to
          assist you with any questions or access requirements.
        </p>

      </div>
    </main>
  );
}
