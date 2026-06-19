"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function ExamHistoryPage() {
  const router = useRouter();

  const [results, setResults] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState<any | null>(null);

  const letters = ["A", "B", "C", "D", "E", "F"];

  const userId =
    typeof window !== "undefined"
      ? localStorage.getItem("userId")
      : null;

  useEffect(() => {
    async function load() {
      if (!userId) return;

      const res = await fetch(`/api/user/results?userId=${userId}`);
      const data = await res.json();

      setResults(data);
      setLoading(false);
    }

    load();
  }, [userId]);

  if (loading)
    return (
      <p className="p-6 text-center text-gray-500">
        Loading...
      </p>
    );

  return (
    <div className="p-3 sm:p-4 md:p-6 bg-gray-50 min-h-screen">

      {/* HEADER */}
      <div className="flex items-center justify-between mb-4">
        <h1 className="text-xl sm:text-2xl font-bold">
          📊 Exam History
        </h1>

        <button
          onClick={() => router.push("/user/dashboard")}
          className="text-sm bg-white border px-3 py-1 rounded-lg shadow hover:bg-gray-100"
        >
          ← Back
        </button>
      </div>

      {/* LIST */}
      {results.length === 0 ? (
        <p className="text-center text-gray-500">
          No exams found
        </p>
      ) : (
        results.map((r) => (
          <div
            key={r.id}
            className="border p-4 mb-3 rounded-xl shadow-sm bg-white"
          >
            <p className="font-semibold text-gray-800">
              Score: {r.score} / {r.total}
            </p>

            <p className="text-sm text-gray-500 mb-2">
              {new Date(r.createdAt).toLocaleString()}
            </p>

            <button
              onClick={() => setSelected(r)}
              className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 text-sm"
            >
              View Review
            </button>
          </div>
        ))
      )}

      {/* MODAL */}
      {selected && (
        <div className="fixed inset-0 bg-black/60 flex items-center justify-center p-2 sm:p-4 z-50">

          <div className="bg-white w-full max-w-4xl rounded-2xl shadow-2xl max-h-[95vh] overflow-y-auto">

            {/* TOP BAR */}
            <div className="sticky top-0 bg-white border-b p-3 flex items-center justify-between">
              
              <button
                onClick={() => setSelected(null)}
                className="text-sm bg-gray-100 px-3 py-1 rounded-lg hover:bg-gray-200"
              >
                ← Back
              </button>

              <h2 className="font-bold text-base sm:text-lg">
                📘 Exam Review
              </h2>

              <button
                onClick={() => setSelected(null)}
                className="bg-gray-900 text-white px-3 py-1 rounded-lg hover:bg-gray-800"
              >
                Close
              </button>
            </div>

            {/* SCORE */}
            <div className="p-3 border-b text-sm sm:text-base font-semibold">
              Score: {selected.score} / {selected.total}
            </div>

            {/* QUESTIONS */}
            <div className="p-3 space-y-5">

              {selected.answers?.map((a: any, i: number) => {
                const q = a.question;

                const correctIndex = q.options.findIndex(
                  (o: any) => o.isCorrect
                );

                const yourIndex = q.options.findIndex(
                  (o: any) => o.id === a.optionId
                );

                return (
                  <div
                    key={a.id}
                    className="border rounded-xl p-3 sm:p-4 bg-gray-50"
                  >

                    {/* QUESTION */}
                    <p className="font-bold mb-2 text-gray-800">
                      Q{i + 1}: {q.translations?.[0]?.text}
                    </p>

                    {/* IMAGE */}
                    {q.image && (
                      <div className="mb-3">
                        <img
                          src={q.image}
                          alt="question"
                          className="w-full max-h-[220px] object-contain rounded-lg border"
                        />
                      </div>
                    )}

                    {/* OPTIONS */}
                    <div className="space-y-2">
                      {q.options.map((opt: any, index: number) => {
                        const isCorrect = index === correctIndex;
                        const isYour = index === yourIndex;

                        return (
                          <div
                            key={opt.id}
                            className={`p-2 sm:p-3 rounded-lg border text-sm sm:text-base ${
                              isCorrect
                                ? "bg-green-100 border-green-500 text-green-800"
                                : isYour
                                ? "bg-red-100 border-red-500 text-red-800"
                                : "bg-white"
                            }`}
                          >
                            <span className="font-bold mr-2">
                              {letters[index] || index + 1}.
                            </span>

                            {opt.translations?.[0]?.text}
                          </div>
                        );
                      })}
                    </div>

                    {/* SUMMARY */}
                    <div className="mt-3 text-sm flex flex-col sm:flex-row gap-2 sm:gap-6">

                      <p>
                        Your answer:{" "}
                        <span className="text-red-600 font-bold">
                          {yourIndex >= 0 ? letters[yourIndex] : "-"}
                        </span>
                      </p>

                      <p>
                        Correct answer:{" "}
                        <span className="text-green-600 font-bold">
                          {correctIndex >= 0 ? letters[correctIndex] : "-"}
                        </span>
                      </p>

                    </div>

                  </div>
                );
              })}
            </div>

            {/* BOTTOM CLOSE */}
            <div className="p-3 border-t">
              <button
                onClick={() => setSelected(null)}
                className="w-full bg-gray-900 text-white py-3 rounded-xl font-bold hover:bg-gray-800"
              >
                Close Review
              </button>
            </div>

          </div>
        </div>
      )}
    </div>
  );
}