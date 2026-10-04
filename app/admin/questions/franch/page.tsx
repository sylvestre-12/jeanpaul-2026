"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";

type Language = "EN" | "FR" | "RW";

type Option = {
  id: number;
  isCorrect: boolean;
  translations: {
    language: Language;
    text: string;
  }[];
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

export default function FrenchQuestionsPage() {
  const router = useRouter();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  const [editingId, setEditingId] = useState<number | null>(null);
  const [editData, setEditData] = useState<any>(null);

  // =========================
  // LOAD
  // =========================
  async function load() {
    setLoading(true);
    const res = await fetch("/api/admin/questions");
    const data = await res.json();
    setQuestions(data);
    setLoading(false);
  }

  useEffect(() => {
    load();
  }, []);

  // =========================
  // DELETE
  // =========================
  async function handleDelete(id: number) {
    if (!confirm("Supprimer cette question ?")) return;

    await fetch(`/api/admin/questions/${id}`, {
      method: "DELETE",
    });

    load();
  }

  // =========================
  // START EDIT
  // =========================
  async function startEdit(id: number) {
    const res = await fetch(`/api/admin/questions/${id}`);
    const data = await res.json();

    setEditingId(id);
    setEditData(data);
  }

  // =========================
  // UPDATE
  // =========================
  async function updateQuestion() {
    const res = await fetch(`/api/admin/questions/${editingId}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        image: editData.image,
        translations: editData.translations,
        options: editData.options, // ✅ IMPORTANT FIX
      }),
    });

    if (!res.ok) {
      alert("Update failed");
      return;
    }

    setEditingId(null);
    setEditData(null);
    load();
  }

  // =========================
  // FILTER + SORT SAFE
  // =========================
  const filtered = useMemo(() => {
    return questions
      .filter((q) => !q.deleted)
      .map((q) => {
        const options = [...(q.options || [])].sort((a, b) => a.id - b.id);

        const text =
          q.translations?.find((t) => t.language === "FR")?.text || "";

        return {
          ...q,
          text,
          options,
        };
      })
      .filter((q) =>
        q.text.toLowerCase().includes(search.toLowerCase())
      );
  }, [questions, search]);

  // =========================
  // SAFE OPTION TEXT
  // =========================
  const getText = (opt?: Option, lang: Language = "FR") => {
    return (
      opt?.translations?.find((t) => t.language === lang)?.text || "-"
    );
  };

  // =========================
  // CORRECT ANSWER
  // =========================
  const getCorrect = (options: Option[] = []) => {
    const index = options.findIndex((o) => o.isCorrect);
    const letters = ["A", "B", "C", "D", "E"];
    return index >= 0 ? letters[index] : "-";
  };

  return (
    <div className="p-6 max-w-7xl mx-auto">

      {/* HEADER */}
      <div className="flex flex-col md:flex-row justify-between gap-3 mb-4">
        <h1 className="text-xl font-bold">📘 Questions Français</h1>

        <button
          onClick={() => router.push("/admin/questions/create")}
          className="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
        >
          + Ajouter
        </button>
      </div>

      {/* SEARCH */}
      <input
        className="border p-2 w-full mb-4 rounded"
        placeholder="Rechercher..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      {/* LOADING */}
      {loading && (
        <p className="text-center text-gray-500">Chargement...</p>
      )}

      {/* EMPTY */}
      {!loading && filtered.length === 0 && (
        <p className="text-center text-gray-500">
          No questions found
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
                <th className="p-2">Question</th>
                <th className="p-2">A</th>
                <th className="p-2">B</th>
                <th className="p-2">C</th>
                <th className="p-2">D</th>
                <th className="p-2">Correct</th>
                <th className="p-2">Actions</th>
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
                      <span className="text-gray-400">No image</span>
                    )}
                  </td>

                  <td className="p-2 font-medium">{q.text}</td>

                  <td className="p-2">{getText(q.options?.[0], "FR")}</td>
                  <td className="p-2">{getText(q.options?.[1], "FR")}</td>
                  <td className="p-2">{getText(q.options?.[2], "FR")}</td>
                  <td className="p-2">{getText(q.options?.[3], "FR")}</td>

                  <td className="p-2 text-green-600 font-bold">
                    {getCorrect(q.options)}
                  </td>

                  <td className="p-2 flex gap-2">
                    <button
                      onClick={() => startEdit(q.id)}
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

      {/* EDIT MODAL */}
      {editingId && editData && (
        <div className="mt-6 p-4 border rounded bg-gray-50">

          <input
            className="border p-2 w-full mb-2 rounded"
            value={editData.image || ""}
            onChange={(e) =>
              setEditData({ ...editData, image: e.target.value })
            }
            placeholder="Image URL"
          />

          {editData.translations?.map((t: any, i: number) => (
            <input
              key={i}
              className="border p-2 w-full mb-2 rounded"
              value={t.text}
              onChange={(e) => {
                const updated = [...editData.translations];
                updated[i].text = e.target.value;
                setEditData({
                  ...editData,
                  translations: updated,
                });
              }}
            />
          ))}

          <div className="flex gap-2">
            <button
              onClick={updateQuestion}
              className="bg-green-600 text-white px-3 py-1 rounded"
            >
              Save
            </button>

            <button
              onClick={() => {
                setEditingId(null);
                setEditData(null);
              }}
              className="bg-gray-400 text-white px-3 py-1 rounded"
            >
              Cancel
            </button>
          </div>

        </div>
      )}

    </div>
  );
}