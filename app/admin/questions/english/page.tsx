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

export default function EnglishQuestionsPage() {
  const router = useRouter();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  // LOAD
  async function loadQuestions() {
    setLoading(true);
    const res = await fetch("/api/admin/questions");
    const data = await res.json();
    setQuestions(data);
    setLoading(false);
  }

  useEffect(() => {
    loadQuestions();
  }, []);

  // DELETE
  async function handleDelete(id: number) {
    const ok = confirm("Are you sure you want to delete this question?");
    if (!ok) return;

    await fetch(`/api/admin/questions/${id}`, {
      method: "DELETE",
    });

    loadQuestions();
  }

  // FILTER (ENGLISH ONLY)
  const filtered = useMemo(() => {
    return questions
      .filter((q) => !q.deleted)
      .map((q) => {
        const text =
          q.translations.find((t) => t.language === "EN")?.text || "";

        return { ...q, text };
      })
      .filter((q) =>
        q.text.toLowerCase().includes(search.toLowerCase())
      );
  }, [questions, search]);

  // CORRECT ANSWER LETTER
  function getCorrectLetter(options: Option[]) {
    const index = options.findIndex((o) => o.isCorrect);
    return index >= 0 ? optionLetters[index] : "-";
  }

  // OPTION TEXT SAFE
  function getOptionText(opt?: Option, lang: Language = "EN") {
    return opt?.translations?.find((t) => t.language === lang)?.text || "-";
  }

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">

      {/* HEADER */}
      <div className="flex justify-between mb-4">
        <h1 className="text-xl font-bold">English Questions</h1>

        <button
          onClick={() => router.push("/admin/questions/create")}
          className="bg-green-600 text-white px-4 py-2 rounded"
        >
          + Add Question
        </button>
      </div>

      {/* SEARCH */}
      <input
        className="border p-2 w-full mb-4 rounded"
        placeholder="Search question..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      {/* LOADING */}
      {loading && (
        <p className="text-center text-gray-500">Loading...</p>
      )}

      {/* TABLE */}
      {!loading && (
        <div className="overflow-x-auto">
          <table className="w-full border text-sm bg-white shadow rounded">

            <thead>
              <tr className="bg-gray-100 text-left">
                <th className="p-2">ID</th>
                <th className="p-2">No</th>
                <th className="p-2">Image</th>
                <th className="p-2">Question</th>
                <th className="p-2">A</th>
                <th className="p-2">B</th>
                <th className="p-2">C</th>
                <th className="p-2">D</th>
                <th className="p-2 text-green-700">Correct</th>
                <th className="p-2">Actions</th>
              </tr>
            </thead>

            <tbody>
              {filtered.map((q) => (
                <tr key={q.id} className="border-t">

                  <td className="p-2">{q.id}</td>
                  <td className="p-2">{q.number}</td>

                  <td className="p-2">
                    {q.image ? (
                      <img
                        src={q.image}
                        className="w-12 h-12 rounded object-cover"
                      />
                    ) : (
                      "-"
                    )}
                  </td>

                  <td className="p-2 font-medium">{q.text}</td>

                  <td className="p-2">
                    {getOptionText(q.options?.[0], "EN")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[1], "EN")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[2], "EN")}
                  </td>
                  <td className="p-2">
                    {getOptionText(q.options?.[3], "EN")}
                  </td>

                  <td className="p-2 text-green-600 font-bold">
                    {getCorrectLetter(q.options || [])}
                  </td>

                  <td className="p-2 flex gap-2">

                    <button
                      onClick={() =>
                        router.push(`/admin/questions/edit/${q.id}`)
                      }
                      className="bg-blue-600 text-white px-2 py-1 rounded"
                    >
                      Edit
                    </button>

                    <button
                      onClick={() => handleDelete(q.id)}
                      className="bg-red-600 text-white px-2 py-1 rounded"
                    >
                      Delete
                    </button>

                  </td>

                </tr>
              ))}
            </tbody>

          </table>
        </div>
      )}

    </div>
  );
}