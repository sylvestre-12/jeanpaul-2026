"use client";

import React, { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

type Translation = {
  language: "EN" | "FR" | "RW";
  text: string;
};

type Option = {
  isCorrect: boolean;
  translations: Translation[];
};

type Question = {
  id: number;
  number: number;

  image?: string;
  images?: { url: string }[];

  translations: Translation[];
  options: Option[];
};

export default function QuestionsPage() {
  const router = useRouter();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  const [editingId, setEditingId] = useState<number | null>(null);
  const [editData, setEditData] = useState<any>(null);

  const letters = ["A", "B", "C", "D", "E", "F"];

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

  async function handleDelete(id: number) {
    if (!confirm("Delete this question?")) return;

    const res = await fetch(`/api/admin/questions/${id}`, {
      method: "DELETE",
    });

    if (!res.ok) return alert("Delete failed");

    loadQuestions();
  }

  async function startEdit(id: number) {
    const res = await fetch(`/api/admin/questions/${id}`);
    const data = await res.json();

    setEditingId(id);
    setEditData(data);
  }

  async function updateQuestion() {
    const res = await fetch(`/api/admin/questions/${editingId}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(editData),
    });

    if (!res.ok) return alert("Update failed");

    setEditingId(null);
    setEditData(null);
    loadQuestions();
  }

  const handleImageUpload = async (file: File) => {
    if (!editingId) return;

    const formData = new FormData();
    formData.append("file", file);
    formData.append("questionId", editingId.toString());

    const res = await fetch("/api/upload", {
      method: "POST",
      body: formData,
    });

    const data = await res.json();

    if (!res.ok) {
      alert(data.error || "Upload failed");
      return;
    }

    setEditData((prev: any) => ({
      ...prev,
      image: data.image?.url || data.url,
    }));
  };

  const removeImage = () => {
    setEditData({ ...editData, image: "" });
  };

  const updateTranslation = (lang: string, value: string) => {
    const updated = editData.translations.map((t: Translation) =>
      t.language === lang ? { ...t, text: value } : t
    );
    setEditData({ ...editData, translations: updated });
  };

  // 🔥 FIXED VERSION (IMPORTANT PART)
  const updateOptionText = (index: number, lang: string, value: string) => {
    const updated = [...editData.options];

    const option = updated[index];

    if (!option.translations) option.translations = [];

    let t = option.translations.find((t: any) => t.language === lang);

    if (!t) {
      t = { language: lang, text: "" };
      option.translations.push(t);
    }

    t.text = value;

    setEditData({ ...editData, options: updated });
  };

  const setCorrect = (index: number) => {
    const updated = editData.options.map((o: any, i: number) => ({
      ...o,
      isCorrect: i === index,
    }));
    setEditData({ ...editData, options: updated });
  };

  const filtered = questions.filter((q) => {
    const searchValue = search.trim().toLowerCase();

    const numberMatch =
      q.number?.toString().trim() === searchValue ||
      q.number?.toString().includes(searchValue);

    const textMatch = q.translations.some((t) =>
      t.text.toLowerCase().includes(searchValue)
    );

    return searchValue ? numberMatch || textMatch : true;
  });

  return (
    <div className="p-4 sm:p-6 max-w-7xl mx-auto">

      {/* HEADER */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 mb-5">
        <h1 className="text-2xl font-bold text-gray-800">
          📘 Questions Management
        </h1>

        <button onClick={() => router.push("/admin/questions/kinyarwanda")}
          className="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg shadow">
          Kinyarwanda
        </button>

        <button onClick={() => router.push("/admin/questions/english")}
          className="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg shadow">
          English
        </button>

        <button onClick={() => router.push("/admin/questions/franch")}
          className="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg shadow">
          Français
        </button>

        <button onClick={() => router.push("/admin/questions/create")}
          className="bg-green-600 hover:bg-green-700 text-white px-5 py-2 rounded-lg shadow">
          + Add Question
        </button>
      </div>

      {/* SEARCH */}
      <div className="flex gap-2 mb-6">
        <input
          className="border p-3 w-full rounded-lg shadow-sm"
          placeholder="Search questions or number..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />

        <button onClick={() => setSearch("")}
          className="bg-gray-400 text-white px-4 rounded-lg">
          Clear
        </button>
      </div>

      {loading && <p className="text-center text-gray-500">Loading...</p>}

      {!loading && (
        <div className="overflow-x-auto rounded-xl shadow-lg border">

          <table className="w-full min-w-[900px] text-sm">

            <thead className="bg-gray-900 text-white sticky top-0">
              <tr>
                <th className="p-4 text-left">ID</th>
                <th className="p-4 text-left">IMAGE</th>
                <th className="p-4 text-left">EN</th>
                <th className="p-4 text-left">FR</th>
                <th className="p-4 text-left">RW</th>
                <th className="p-4 text-left">ACTIONS</th>
              </tr>
            </thead>

            <tbody>
              {filtered.map((q) => {
                const get = (lang: string) =>
                  q.translations.find((t) => t.language === lang)?.text;

                return (
                  <React.Fragment key={q.id}>

                    {editingId && editingId !== q.id ? null : (
                      <tr className="border-b hover:bg-gray-50">

                        <td className="p-4 font-semibold">{q.number}</td>

                        <td className="p-4">
  {q.images?.length ? (
    <div className="w-16 h-12 sm:w-20 sm:h-14 md:w-24 md:h-16 rounded-lg overflow-hidden bg-gray-100 flex items-center justify-center">
      <img
        src={q.images[0].url}
        className="w-full h-full object-contain"
      />
    </div>
  ) : q.image ? (
    <div className="w-14 h-12 sm:w-18 sm:h-14 md:w-20 md:h-16 rounded-lg overflow-hidden bg-gray-100 flex items-center justify-center">
      <img
        src={q.image}
        className="w-full h-full object-contain"
      />
    </div>
  ) : (
    <span className="text-gray-400 text-xs">No image</span>
  )}
</td>

                        <td className="p-4">{get("EN")}</td>
                        <td className="p-4">{get("FR")}</td>
                        <td className="p-4">{get("RW")}</td>

                        <td className="p-4 flex gap-2">
                          <button onClick={() => startEdit(q.id)}
                            className="bg-blue-600 text-white px-3 py-1 rounded">
                            Edit
                          </button>

                          <button onClick={() => handleDelete(q.id)}
                            className="bg-red-600 text-white px-3 py-1 rounded">
                            Delete
                          </button>
                        </td>
                      </tr>
                    )}

                    {editingId === q.id && editData && (
                      <tr>
                        <td colSpan={6} className="p-6 bg-gray-50">

                          <input
                            type="file"
                            className="mb-3"
                            onChange={(e) =>
                              e.target.files &&
                              handleImageUpload(e.target.files[0])
                            }
                          />

                          {editData.image && (
                            <div className="flex items-center gap-3 mb-4">
                              <img
                                src={editData.image}
                                className="w-24 rounded shadow"
                              />
                              <button
                                onClick={removeImage}
                                className="text-red-600"
                              >
                                Remove
                              </button>
                            </div>
                          )}

                          <h3 className="font-bold mb-2">Question</h3>

                          {["EN", "FR", "RW"].map((lang) => (
                            <input
                              key={lang}
                              className="border p-2 w-full mb-2 rounded"
                              value={
                                editData.translations.find(
                                  (t: Translation) => t.language === lang
                                )?.text || ""
                              }
                              onChange={(e) =>
                                updateTranslation(lang, e.target.value)
                              }
                            />
                          ))}

                          <h3 className="font-bold mt-4 mb-2">Options</h3>

                          {editData.options.map((opt: any, i: number) => (
                            <div key={i} className="border p-4 mb-3 bg-white rounded">

                              <div className="text-center text-blue-600 font-bold mb-2">
                                {letters[i] || i + 1}
                              </div>

                              {["EN", "FR", "RW"].map((lang) => (
                                <input
                                  key={lang}
                                  className="border p-2 w-full mb-1 rounded"
                                  value={
                                    opt.translations?.find(
                                      (t: any) => t.language === lang
                                    )?.text || ""
                                  }
                                  onChange={(e) =>
                                    updateOptionText(i, lang, e.target.value)
                                  }
                                />
                              ))}

                              <label className="flex items-center gap-2 mt-2">
                                <input
                                  type="radio"
                                  checked={opt.isCorrect}
                                  onChange={() => setCorrect(i)}
                                />
                                Correct
                              </label>
                            </div>
                          ))}

                          <div className="flex gap-3 mt-4">
                            <button
                              onClick={updateQuestion}
                              className="bg-green-600 text-white px-4 py-2 rounded"
                            >
                              Save
                            </button>

                            <button
                              onClick={() => {
                                setEditingId(null);
                                setEditData(null);
                              }}
                              className="bg-gray-500 text-white px-4 py-2 rounded"
                            >
                              Cancel
                            </button>
                          </div>

                        </td>
                      </tr>
                    )}

                  </React.Fragment>
                );
              })}
            </tbody>

          </table>
        </div>
      )}
    </div>
  );
}