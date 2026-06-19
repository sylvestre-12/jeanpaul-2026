"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";

type Language = "EN" | "FR" | "RW";

type OptionTranslation = {
  language: Language;
  text: string;
};

type Option = {
  id: number;
  isCorrect: boolean;
  translations: OptionTranslation[];
};

type Question = {
  id: number;
  number: number;
  image?: string | null;
  deleted: boolean;
  translations: {
    language: Language;
    text: string;
  }[];
  options: Option[];
};

const optionLetters = ["A", "B", "C", "D", "E"];

export default function KinyarwandaQuestionsPage() {
  const router = useRouter();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  // =========================
  // LOAD FROM DATABASE
  // =========================
  async function loadQuestions() {
    try {
      setLoading(true);

      const res = await fetch("/api/admin/questions");
      const data = await res.json();

      setQuestions(data);
    } catch (error) {
      console.error("LOAD ERROR:", error);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadQuestions();
  }, []);

  // =========================
  // DELETE (SOFT DELETE READY)
  // =========================
  async function handleDelete(id: number) {
    const ok = confirm("Urifuza gusiba iki kibazo?");
    if (!ok) return;

    await fetch(`/api/admin/questions/${id}`, {
      method: "DELETE",
    });

    loadQuestions();
  }

  // =========================
  // RW TEXT ONLY + SEARCH
  // =========================
  const filtered = useMemo(() => {
    return questions
      .filter((q) => !q.deleted)
      .map((q) => {
        const rwText =
          q.translations.find((t) => t.language === "RW")?.text || "";

        return { ...q, rwText };
      })
      .filter((q) =>
        q.rwText.toLowerCase().includes(search.toLowerCase())
      );
  }, [questions, search]);

  // =========================
  // GET CORRECT OPTION LETTER
  // =========================
  function getCorrectLetter(options: Option[]) {
    const index = options.findIndex((o) => o.isCorrect);
    return index >= 0 ? optionLetters[index] : "-";
  }

  // =========================
  // GET RW OPTION TEXT (FIXED SAFE)
  // =========================
  function getOptionText(opt: Option | undefined, lang: Language) {
    if (!opt?.translations) return "-";

    return (
      opt.translations.find((t) => t.language === lang)?.text || "-"
    );
  }

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">

      {/* HEADER */}
      <div className="flex flex-col md:flex-row justify-between gap-3 mb-4">

        <h1 className="text-xl font-bold">
          Kinyarwanda Questions
        </h1>

        <button
          onClick={() =>
            router.push("/admin/questions/create")
          }
          className="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
        >
          + Add Question
        </button>

      </div>

      {/* SEARCH */}
      <input
        className="border p-2 w-full mb-4 rounded"
        placeholder="Shakisha ikibazo..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      {/* LOADING */}
      {loading && (
        <p className="text-gray-500 text-center">
          Loading...
        </p>
      )}

      {/* TABLE */}
      {!loading && filtered.length > 0 && (
        <div className="overflow-x-auto">

          <table className="w-full border text-sm bg-white shadow rounded">

            <thead>
              <tr className="bg-gray-100 text-left">
                <th className="p-2">ID</th>
                <th className="p-2">No</th>
                <th className="p-2">Image</th>
                <th className="p-2">Ikibazo A</th>
                <th className="p-2">Igisubizo A</th>
                <th className="p-2">Igisubizo B</th>
                <th className="p-2">Igisubizo C</th>
                <th className="p-2">IgisubizoD</th>
                <th className="p-2 text-green-700">Igisubizo Cy'ukuri</th>
                <th className="p-2">Igikorwa</th>
              </tr>
            </thead>

            <tbody>
              {filtered.map((q) => (
                <tr key={q.id} className="border-t hover:bg-gray-50">

                  <td className="p-2">{q.id}</td>
                  <td className="p-2">{q.number}</td>

                  <td className="p-2">
                    {q.image ? (
                      <img
                        src={q.image}
                        className="w-12 h-12 object-cover rounded"
                      />
                    ) : (
                      <span className="text-gray-400">-</span>
                    )}
                  </td>

                  <td className="p-2 font-medium">
                    {q.rwText}
                  </td>

                  <td className="p-2">
                    {getOptionText(q.options?.[0], "RW")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[1], "RW")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[2], "RW")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[3], "RW")}
                  </td>

                  <td className="p-2 font-bold text-green-600">
                    {getCorrectLetter(q.options || [])}
                  </td>

                  <td className="p-2 flex gap-2">

                    <button
                      onClick={() =>
                        router.push(`/admin/questions/edit/${q.id}`)
                      }
                      className="bg-blue-600 text-white px-2 py-1 rounded"
                    >
                      Guhindura
                    </button>

                    <button
                      onClick={() => handleDelete(q.id)}
                      className="bg-red-600 text-white px-2 py-1 rounded"
                    >
                      Gusiba
                    </button>

                  </td>

                </tr>
              ))}
            </tbody>

          </table>
        </div>
      )}

      {/* EMPTY */}
      {!loading && filtered.length === 0 && (
        <p className="text-gray-500 text-center">
          No questions found
        </p>
      )}

    </div>
  );
}