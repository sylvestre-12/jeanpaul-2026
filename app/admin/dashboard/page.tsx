"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function AdminDashboard() {
  const router = useRouter();

  const [adminName, setAdminName] = useState("Admin");
  const [adminPhone, setAdminPhone] = useState("");

  useEffect(() => {
    setAdminName(localStorage.getItem("userName") || "Admin");
    setAdminPhone(localStorage.getItem("userPhone") || "");
  }, []);

  const logout = () => {
    localStorage.clear();
    router.push("/");
  };

  const cards = [
    {
      title: "Users",
      desc: "Manage users and account approvals",
      icon: "👥",
      path: "/admin/users",
      color: "bg-blue-600",
    },
    {
      title: "Questions",
      desc: "Create, edit and manage questions",
      icon: "📚",
      path: "/admin/questions",
      color: "bg-green-600",
    },
    {
      title: "User Tests",
      desc: "Create, manage and assign tests",
      icon: "📝",
      path: "/admin/test",
      color: "bg-purple-600",
    },
    {
      title: "Create Question & Send",
      desc: "Choose 20 questions, generate PDF and send to users",
      icon: "📤",
      path: "/admin/send-test",
      color: "bg-orange-600",
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200">

      {/* HEADER */}
      <div className="bg-white shadow-md border-b sticky top-0 z-50">
        <div className="max-w-7xl mx-auto p-3 sm:p-4 flex flex-col sm:flex-row justify-between items-center gap-3">

          <div>
            <h1 className="text-xl sm:text-2xl font-bold text-gray-800">
              🛠️ Admin Dashboard
            </h1>

            <p className="text-xs sm:text-sm text-gray-500">
              Manage users, questions and tests
            </p>
          </div>

          <button
            onClick={logout}
            className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg font-medium"
          >
            Logout
          </button>
        </div>
      </div>

      {/* ADMIN CARD */}
      <div className="max-w-7xl mx-auto p-3 sm:p-6">

        <div className="bg-white rounded-2xl shadow-md p-4 sm:p-6 mb-6">
          <h2 className="text-lg sm:text-xl font-bold text-gray-800">
            Welcome Admin
          </h2>

          <div className="mt-3 space-y-2 text-gray-600">
            <p>👤 {adminName}</p>
            <p>📱 {adminPhone}</p>
          </div>
        </div>

        {/* DASHBOARD GRID */}
        <div className="grid grid-cols-1 xs:grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">

          {cards.map((card, index) => (
            <button
              key={index}
              onClick={() => router.push(card.path)}
              className={`${card.color}
                text-white
                rounded-2xl
                p-5
                shadow-lg
                hover:scale-105
                active:scale-95
                transition
                text-left
                min-h-[180px]
                flex
                flex-col
                justify-between`}
            >
              <div className="text-4xl">
                {card.icon}
              </div>

              <div>
                <h2 className="font-bold text-lg mb-2">
                  {card.title}
                </h2>

                <p className="text-sm opacity-95">
                  {card.desc}
                </p>
              </div>
            </button>
          ))}

        </div>

        {/* FOOTER */}
        <div className="text-center text-gray-500 text-xs sm:text-sm mt-10 pb-6">
          © {new Date().getFullYear()} Driving License Examination System
        </div>

      </div>
    </div>
  );
}