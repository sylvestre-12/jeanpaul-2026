"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";

export default function AdminExamResultsPage() {
  const router = useRouter();

  const [results, setResults] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState<any | null>(null);
  const [search, setSearch] = useState("");

  const letters = ["A", "B", "C", "D", "E", "F"];

  // ================= LOAD =================
  useEffect(() => {
    async function load() {
      try {
        const res = await fetch("/api/admin/results");
        const data = await res.json();
        setResults(data);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, []);

  // ================= DELETE =================
  async function handleDelete(id: number) {
    const ok = confirm("Delete this result?");
    if (!ok) return;

    await fetch(`/api/admin/results/${id}`, {
      method: "DELETE",
    });

    setResults((prev) => prev.filter((r) => r.id !== id));
  }

  // ================= SEARCH =================
  const filtered = useMemo(() => {
    return results.filter((r) => {
      const name = r.user?.name || "";
      const phone = r.user?.phone || "";

      return (
        name.toLowerCase().includes(search.toLowerCase()) ||
        phone.toLowerCase().includes(search.toLowerCase())
      );
    });
  }, [results, search]);

  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center text-gray-500 text-sm sm:text-base">
        Loading results...
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-2 sm:p-4 md:p-6">

      {/* ================= HEADER ================= */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-5">

        <div>
          <h1 className="text-lg sm:text-2xl font-bold text-gray-800">
            📊 Exam Results (Admin Panel)
          </h1>
          <p className="text-xs sm:text-sm text-gray-500">
            Manage all user exam submissions
          </p>
        </div>

        <button
          onClick={() => router.push("/admin/dashboard")}
          className="bg-white border px-3 py-2 rounded-lg shadow hover:bg-gray-100 text-sm w-full sm:w-auto"
        >
          ← Back Dashboard
        </button>
      </div>

      {/* ================= SEARCH ================= */}
      <div className="mb-5">
        <input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search by name or phone..."
          className="w-full p-3 text-sm sm:text-base border rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 outline-none"
        />
      </div>

      {/* ================= LIST ================= */}
      {filtered.length === 0 ? (
        <p className="text-center text-gray-500 text-sm">
          No results found
        </p>
      ) : (
        <div className="space-y-3">
          {filtered.map((r) => (
            <div
              key={r.id}
              className="bg-white border rounded-xl p-3 sm:p-4 shadow-sm flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3"
            >
              {/* USER INFO */}
              <div className="space-y-1">
                <p className="font-semibold text-sm sm:text-base text-gray-800">
                  👤 {r.user?.name || "Unknown"}
                </p>
                <p className="text-xs sm:text-sm text-gray-500">
                  📱 {r.user?.phone}
                </p>
                <p className="text-xs text-gray-400">
                  🕒 {new Date(r.createdAt).toLocaleString()}
                </p>
              </div>

              {/* SCORE */}
              <div className="text-sm font-semibold text-gray-700">
                Score: {r.score} / {r.total}
              </div>

              {/* ACTIONS */}
              <div className="flex gap-2 w-full sm:w-auto">
                <button
                  onClick={() => setSelected(r)}
                  className="flex-1 sm:flex-none bg-blue-600 text-white px-3 py-2 rounded-lg text-sm hover:bg-blue-700"
                >
                  View
                </button>

                <button
                  onClick={() => handleDelete(r.id)}
                  className="flex-1 sm:flex-none bg-red-600 text-white px-3 py-2 rounded-lg text-sm hover:bg-red-700"
                >
                  Delete
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* ================= MODAL ================= */}
      {selected && (
        <div className="fixed inset-0 bg-black/60 flex items-center justify-center p-2 sm:p-4 z-50">

          <div className="bg-white w-full max-w-5xl rounded-2xl shadow-2xl max-h-[95vh] overflow-y-auto">

            {/* TOP BAR */}
            <div className="sticky top-0 bg-white border-b p-3 flex items-center justify-between">
              <button
                onClick={() => setSelected(null)}
                className="text-xs sm:text-sm bg-gray-100 px-3 py-1 rounded-lg hover:bg-gray-200"
              >
                ← Back
              </button>

              <h2 className="font-bold text-sm sm:text-base">
                📘 Exam Review
              </h2>

              <button
                onClick={() => setSelected(null)}
                className="bg-black text-white px-3 py-1 rounded-lg text-xs sm:text-sm"
              >
                Close
              </button>
            </div>

            {/* USER SUMMARY */}
            <div className="p-3 border-b text-sm sm:text-base font-semibold text-gray-800">
              👤 {selected.user?.name} | 📱 {selected.user?.phone}
              <br />
              Score: {selected.score} / {selected.total}
            </div>

            {/* QUESTIONS */}
            <div className="p-3 sm:p-4 space-y-5">

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
                    <p className="font-semibold text-sm sm:text-base mb-2">
                      Q{i + 1}: {q.translations?.[0]?.text}
                    </p>

                    {/* IMAGE */}
                    {q.image && (
                      <img
                        src={q.image}
                        className="w-full max-h-[220px] object-contain rounded-lg mb-3 border"
                      />
                    )}

                    {/* OPTIONS */}
                    <div className="space-y-2">
                      {q.options.map((opt: any, index: number) => {
                        const isCorrect = index === correctIndex;
                        const isYour = index === yourIndex;

                        return (
                          <div
                            key={opt.id}
                            className={`p-2 sm:p-3 rounded-lg border text-xs sm:text-sm ${
                              isCorrect
                                ? "bg-green-100 border-green-500 text-green-800"
                                : isYour
                                ? "bg-red-100 border-red-500 text-red-800"
                                : "bg-white"
                            }`}
                          >
                            <b className="mr-2">
                              {letters[index] || index + 1}.
                            </b>
                            {opt.translations?.[0]?.text}
                          </div>
                        );
                      })}
                    </div>

                    {/* SUMMARY */}
                    <div className="mt-3 flex flex-col sm:flex-row gap-2 sm:gap-6 text-xs sm:text-sm">

                      <p>
                        Your answer:{" "}
                        <span className="font-bold text-red-600">
                          {yourIndex >= 0 ? letters[yourIndex] : "-"}
                        </span>
                      </p>

                      <p>
                        Correct answer:{" "}
                        <span className="font-bold text-green-600">
                          {correctIndex >= 0 ? letters[correctIndex] : "-"}
                        </span>
                      </p>

                    </div>

                  </div>
                );
              })}
            </div>

            {/* BOTTOM */}
            <div className="p-3 border-t">
              <button
                onClick={() => setSelected(null)}
                className="w-full bg-black text-white py-3 rounded-xl text-sm sm:text-base font-semibold"
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