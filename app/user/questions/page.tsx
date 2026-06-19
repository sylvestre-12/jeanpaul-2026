"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

type Language = "EN" | "FR" | "RW";

type Translation = {
  language: Language;
  text: string;
};

type Option = {
  id: number; // ✅ FIXED (this was missing)
  isCorrect: boolean;
  translations: Translation[];
};

type Question = {
  id: number;
  number: number;
  image?: string;
  translations: Translation[];
  options: Option[];
};

export default function UserQuestionsPage() {
  const router = useRouter();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);

  const lang =
    typeof window !== "undefined"
      ? ((localStorage.getItem("app_lang") as Language) || "EN")
      : "EN";

  useEffect(() => {
    async function load() {
      const res = await fetch(`/api/user/questions?lang=${lang}`);
      const data = await res.json();

      const safeData = (data || []).map((q: any) => ({
        ...q,
        translations: q.translations || [],
        options: (q.options || []).map((o: any) => ({
          ...o,
          translations: o.translations || [],
        })),
      }));

      setQuestions(safeData);
      setLoading(false);
    }

    load();
  }, [lang]);

  function getQuestionText(q: Question) {
    return q?.translations?.find((t) => t.language === lang)?.text || "-";
  }

  function getOptionText(opt?: Option) {
    return opt?.translations?.find((t) => t.language === lang)?.text || "-";
  }

  const letters = ["A", "B", "C", "D", "E"];

  function getCorrectIndex(options?: Option[]) {
    if (!options) return -1;
    return options.findIndex((o) => o.isCorrect);
  }

  if (loading)
    return (
      <p className="p-6 text-center text-gray-500">
        Loading...
      </p>
    );

  return (
    <div className="p-3 sm:p-4 md:p-6 max-w-7xl mx-auto">

      {/* HEADER */}
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-lg sm:text-2xl font-bold text-gray-800">
          📘 Read Questions & Answers
        </h1>

        <button
          onClick={() => router.back()}
          className="bg-gray-900 hover:bg-black text-white px-4 py-2 rounded-lg text-sm sm:text-base"
        >
          ⬅ Back
        </button>
      </div>

      {/* TABLE */}
      <div className="overflow-x-auto rounded-xl border shadow bg-white">

        <table className="w-full min-w-[750px] text-sm sm:text-base">

          <thead className="bg-gray-900 text-white">
            <tr>
              <th className="p-3 text-left">No</th>
              <th className="p-3 text-left">Image</th>
              <th className="p-3 text-left">Question</th>
              <th className="p-3 text-left">A</th>
              <th className="p-3 text-left">B</th>
              <th className="p-3 text-left">C</th>
              <th className="p-3 text-left">D</th>
              <th className="p-3 text-left text-blue-400">
                Correct
              </th>
            </tr>
          </thead>

          <tbody>
            {questions.map((q) => {
              const correctIndex = getCorrectIndex(q.options);

              return (
                <tr
                  key={q.id}
                  className="border-t hover:bg-gray-50"
                >

                  {/* NUMBER */}
                  <td className="p-3 font-bold text-black">
                    {q.number}
                  </td>

                  {/* IMAGE */}
                  <td className="p-3">
                    {q.image ? (
                      <div className="w-[60px] sm:w-[90px] md:w-[110px] lg:w-[130px]">
                        <img
                          src={q.image}
                          alt="question"
                          className="w-full h-auto object-contain rounded-md shadow"
                        />
                      </div>
                    ) : (
                      <span className="text-gray-400">-</span>
                    )}
                  </td>

                  {/* QUESTION */}
                  <td className="p-3 font-bold text-black">
                    {getQuestionText(q)}
                  </td>

                  {/* OPTIONS */}
                  {q.options.slice(0, 4).map((opt, i) => (
                    <td
                      key={opt.id}
                      className={`p-3 font-medium ${
                        i === correctIndex
                          ? "text-blue-600 font-bold"
                          : "text-black"
                      }`}
                    >
                      {getOptionText(opt)}
                    </td>
                  ))}

                  {/* CORRECT */}
                  <td className="p-3 font-bold text-blue-600">
                    {correctIndex >= 0
                      ? letters[correctIndex]
                      : "-"}
                  </td>

                </tr>
              );
            })}
          </tbody>

        </table>
      </div>
    </div>
  );
}