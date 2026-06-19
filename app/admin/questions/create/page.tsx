"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

type Option = {
  en: string;
  fr: string;
  rw: string;
  isCorrect: boolean;
};

export default function CreateQuestion() {
  const router = useRouter();

  const [image, setImage] = useState("");

  const [en, setEn] = useState("");
  const [fr, setFr] = useState("");
  const [rw, setRw] = useState("");

  const [options, setOptions] = useState<Option[]>([
    { en: "", fr: "", rw: "", isCorrect: false },
    { en: "", fr: "", rw: "", isCorrect: false },
  ]);

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const letters = ["A", "B", "C", "D", "E", "F", "G"];

  // ➕ Add option
  function addOption() {
    setOptions((prev) => [
      ...prev,
      { en: "", fr: "", rw: "", isCorrect: false },
    ]);
  }

  // ❌ Remove option
  function removeOption(index: number) {
    setOptions((prev) => prev.filter((_, i) => i !== index));
  }

  // ✏️ Update option
  function updateOption(
    index: number,
    field: "en" | "fr" | "rw",
    value: string
  ) {
    setOptions((prev) =>
      prev.map((opt, i) =>
        i === index ? { ...opt, [field]: value } : opt
      )
    );
  }

  // ✅ Set correct answer
  function setCorrect(index: number) {
    setOptions((prev) =>
      prev.map((opt, i) => ({
        ...opt,
        isCorrect: i === index,
      }))
    );
  }

  // ✅ Validation
  function validate() {
    if (!en || !fr || !rw) return "Question translations required";

    if (options.length < 2) return "Minimum 2 options required";

    if (!options.some((o) => o.isCorrect))
      return "Select correct answer";

    for (const opt of options) {
      if (!opt.en || !opt.fr || !opt.rw) {
        return "Each option must have EN, FR, RW";
      }
    }

    return "";
  }

  // 🚀 Submit
  async function submit() {
    const err = validate();
    if (err) return setError(err);

    try {
      setLoading(true);
      setError("");

      const res = await fetch("/api/admin/questions", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          type: "NORMAL",
          image,
          translations: [
            { language: "EN", text: en },
            { language: "FR", text: fr },
            { language: "RW", text: rw },
          ],
          options: options.map((opt) => ({
            isCorrect: opt.isCorrect,
            translations: [
              { language: "EN", text: opt.en },
              { language: "FR", text: opt.fr },
              { language: "RW", text: opt.rw },
            ],
          })),
        }),
      });

      const data = await res.json();

      if (!res.ok) {
        setError(data.error || "Failed to create question");
        return;
      }

      router.push("/admin/questions");
    } catch {
      setError("Server error");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="p-4 sm:p-6 max-w-3xl mx-auto">

      {/* TITLE */}
      <h1 className="text-xl sm:text-2xl font-bold mb-5 text-gray-800">
        ➕ Create Traffic Question
      </h1>

      {/* ERROR */}
      {error && (
        <div className="bg-red-100 text-red-700 p-3 mb-4 rounded">
          {error}
        </div>
      )}

      {/* IMAGE URL */}
      <input
        className="border p-3 w-full mb-3 rounded focus:ring-2 focus:ring-green-500"
        placeholder="Paste image URL here..."
        value={image}
        onChange={(e) => setImage(e.target.value)}
      />

      {/* IMAGE PREVIEW */}
      {image && (
        <img
          src={image}
          className="w-44 mb-4 rounded shadow border"
          alt="preview"
        />
      )}

      {/* QUESTION */}
      <h2 className="font-semibold mb-2 text-gray-700">
        Question (EN / FR / RW)
      </h2>

      <textarea
        className="border p-2 w-full mb-2 rounded"
        placeholder="English"
        value={en}
        onChange={(e) => setEn(e.target.value)}
      />

      <textarea
        className="border p-2 w-full mb-2 rounded"
        placeholder="Français"
        value={fr}
        onChange={(e) => setFr(e.target.value)}
      />

      <textarea
        className="border p-2 w-full mb-4 rounded"
        placeholder="Kinyarwanda"
        value={rw}
        onChange={(e) => setRw(e.target.value)}
      />

      {/* OPTIONS */}
      <h2 className="font-semibold mb-3 text-gray-700">
        Options
      </h2>

      {options.map((opt, i) => (
        <div
          key={i}
          className="border p-3 mb-3 rounded bg-white shadow-sm"
        >

          {/* A, B, C, D */}
          <div className="text-center text-blue-600 font-bold mb-2 text-lg">
            {letters[i] || String.fromCharCode(65 + i)}
          </div>

          {/* INPUTS */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2 mb-3">

            <input
              placeholder="EN"
              className="border p-2 rounded"
              value={opt.en}
              onChange={(e) =>
                updateOption(i, "en", e.target.value)
              }
            />

            <input
              placeholder="FR"
              className="border p-2 rounded"
              value={opt.fr}
              onChange={(e) =>
                updateOption(i, "fr", e.target.value)
              }
            />

            <input
              placeholder="RW"
              className="border p-2 rounded"
              value={opt.rw}
              onChange={(e) =>
                updateOption(i, "rw", e.target.value)
              }
            />
          </div>

          {/* ACTIONS */}
          <div className="flex justify-between items-center">

            <label className="flex items-center gap-2 text-green-600 font-medium">
              <input
                type="radio"
                name="correct"
                checked={opt.isCorrect}
                onChange={() => setCorrect(i)}
              />
              Correct
            </label>

            <button
              onClick={() => removeOption(i)}
              className="text-red-600 hover:text-red-800 text-sm"
            >
              Remove
            </button>

          </div>
        </div>
      ))}

      {/* ADD OPTION */}
      <button
        onClick={addOption}
        className="text-blue-600 font-semibold mb-4"
      >
        + Add Option
      </button>

      {/* SUBMIT */}
      <button
        onClick={submit}
        disabled={loading}
        className="w-full bg-green-600 text-white p-3 rounded hover:bg-green-700 disabled:opacity-50"
      >
        {loading ? "Creating..." : "Create Question"}
      </button>

    </div>
  );
}