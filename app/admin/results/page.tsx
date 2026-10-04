"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";

export default function ResultsPage() {
  const [results, setResults] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const router = useRouter();

  useEffect(() => {
    const userId = localStorage.getItem("userId");

    if (!userId) {
      setLoading(false);
      return;
    }

    fetch(`/api/user/results?userId=${userId}`)
      .then((r) => r.json())
      .then((data) => {
        setResults(data);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  // AUTO REDIRECT AFTER 5 SECONDS
  useEffect(() => {
    const timer = setTimeout(() => {
      router.push("/admin/dashboard");
    }, 5000);

    return () => clearTimeout(timer);
  }, [router]);

  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center font-bold">
        Loading results...
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100 p-6 flex justify-center">

      <div className="w-full max-w-3xl">

        <h1 className="text-3xl font-bold mb-6 text-center">
          🏆 Exam Results
        </h1>

        {results.length === 0 ? (
          <div className="text-center text-gray-500">
            No results found
          </div>
        ) : (
          results.map((r: any) => {
            const percentage = Math.round((r.score / r.total) * 100);
            const passed = percentage >= 50;

            return (
              <div
                key={r.id}
                className="bg-white shadow rounded-xl p-5 mb-4 border"
              >

                <div className="flex justify-between mb-2">
                  <span className="font-bold">
                    Score: {r.score} / {r.total}
                  </span>

                  <span
                    className={`font-bold ${
                      passed ? "text-green-600" : "text-red-600"
                    }`}
                  >
                    {passed ? "PASS 🎉" : "FAIL ❌"}
                  </span>
                </div>

                <div className="text-gray-700 mb-2">
                  📊 Percentage: {percentage}%
                </div>

                <div className="text-sm text-gray-500">
                  🕒 {new Date(r.createdAt).toLocaleString()}
                </div>

              </div>
            );
          })
        )}

        <div className="mt-6 text-center text-sm text-gray-500">
          Redirecting to dashboard in 5 seconds...
        </div>

      </div>
    </div>
  );
}