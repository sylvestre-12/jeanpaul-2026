"use client";

import { useEffect, useState } from "react";
import jsPDF from "jspdf";
import { useRouter } from "next/navigation";

type Language = "EN" | "FR" | "RW";

export default function SendTestPage() {
  const router = useRouter();

  const [language, setLanguage] = useState<Language>("EN");
  const [questions, setQuestions] = useState<any[]>([]);
  const [selected, setSelected] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const adminName =
    typeof window !== "undefined"
      ? localStorage.getItem("userName") || "Admin"
      : "Admin";

  const adminPhone =
    typeof window !== "undefined"
      ? localStorage.getItem("userPhone") || ""
      : "";

  useEffect(() => {
    async function load() {
      const res = await fetch("/api/admin/export-questions");
      const data = await res.json();
      setQuestions(data);
      setLoading(false);
    }
    load();
  }, []);

  function toggleSelect(q: any) {
    const exists = selected.find((x) => x.id === q.id);

    if (exists) {
      setSelected(selected.filter((x) => x.id !== q.id));
    } else {
      if (selected.length >= 20) {
        alert("You can only select 20 questions");
        return;
      }
      setSelected([...selected, q]);
    }
  }

  function getText(q: any) {
    return (
      q.translations?.find((t: any) => t.language === language)?.text ||
      "No translation"
    );
  }

  function getOptionText(o: any) {
    return (
      o.translations?.find((t: any) => t.language === language)?.text ||
      "No translation"
    );
  }

  async function downloadPDF() {
    const doc = new jsPDF();
    const date = new Date().toLocaleString();

    let y = 10;

    doc.setFontSize(14);
    doc.text("DRIVING TEST EXAM", 10, y);
    y += 10;

    doc.setFontSize(10);
    doc.text(`Prepared by: ${adminName}`, 10, y);
    y += 6;

    doc.text(`Phone: ${adminPhone}`, 10, y);
    y += 6;

    doc.text(`Date: ${date}`, 10, y);
    y += 10;

    doc.text("------------------------------------", 10, y);
    y += 10;

    for (let i = 0; i < selected.length; i++) {
      const q = selected[i];

      const qText = `${i + 1}. ${getText(q)}`;
      const splitQ = doc.splitTextToSize(qText, 180);

      doc.text(splitQ, 10, y);
      y += splitQ.length * 6;

      if (q.image) {
        try {
          const res = await fetch(q.image);
          const blob = await res.blob();

          const base64 = await new Promise<string>((resolve) => {
            const reader = new FileReader();
            reader.onloadend = () => resolve(reader.result as string);
            reader.readAsDataURL(blob);
          });

          // 🔽 SMALLER IMAGE IN PDF
          doc.addImage(base64, "JPEG", 12, y, 55, 28);
          y += 32;
        } catch {}
      }

      q.options.forEach((o: any, idx: number) => {
        const text = `${String.fromCharCode(65 + idx)}. ${getOptionText(o)}`;
        const split = doc.splitTextToSize(text, 180);
        doc.text(split, 10, y);
        y += split.length * 5;
      });

      y += 6;

      if (y > 270) {
        doc.addPage();
        y = 10;
      }
    }

    doc.save(`exam-${language}.pdf`);
  }

  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center text-gray-500 text-sm">
        Loading questions...
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-2 sm:p-4 md:p-6">

      {/* HEADER */}
      <div className="sticky top-0 z-50 bg-white border-b shadow-sm p-2 sm:p-3 mb-4">

        <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">

          <div>
            <h1 className="text-base sm:text-xl md:text-2xl font-bold">
              📤 Exam Generator
            </h1>
            <p className="text-[10px] sm:text-xs text-gray-500">
              Select up to 20 questions
            </p>
          </div>

          <div className="flex flex-wrap gap-2 items-center">

            <button
              onClick={() => router.push("/admin/dashboard")}
              className="text-xs sm:text-sm bg-white border px-2 sm:px-3 py-1 rounded-lg"
            >
              ← Back
            </button>

            <select
              value={language}
              onChange={(e) => setLanguage(e.target.value as Language)}
              className="text-xs sm:text-sm border p-1 sm:p-2 rounded-lg"
            >
              <option value="EN">EN</option>
              <option value="FR">FR</option>
              <option value="RW">RW</option>
            </select>

            <button
              onClick={downloadPDF}
              disabled={selected.length === 0}
              className="text-xs sm:text-sm bg-blue-600 text-white px-3 py-1 sm:px-4 sm:py-2 rounded-lg disabled:opacity-50"
            >
              PDF ({selected.length}/20)
            </button>

          </div>
        </div>
      </div>

      {/* GRID */}
      <div className="grid grid-cols-1 xs:grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2 sm:gap-4">

        {questions.map((q) => {
          const isSelected = selected.find((x) => x.id === q.id);

          return (
            <div
              key={q.id}
              onClick={() => toggleSelect(q)}
              className={`rounded-xl border cursor-pointer p-2 sm:p-3 transition
                ${isSelected ? "bg-green-100 border-green-500" : "bg-white"}`}
            >

              {/* QUESTION TEXT */}
              <h2 className="text-xs sm:text-sm font-semibold mb-2 leading-tight">
                {getText(q)}
              </h2>

              {/* IMAGE SMALL (IMPORTANT FIX) */}
              {q.image && (
                <img
                  src={q.image}
                  className="w-full h-20 sm:h-24 object-cover rounded mb-2"
                />
              )}

              {/* OPTIONS */}
              <div className="text-[10px] sm:text-xs text-gray-600 space-y-[2px]">
                {q.options.map((o: any, i: number) => (
                  <p key={o.id}>
                    {String.fromCharCode(65 + i)}. {getOptionText(o)}
                  </p>
                ))}
              </div>

              {/* STATUS */}
              <p className="text-[10px] sm:text-xs mt-2 text-gray-500">
                {isSelected ? "✅ Selected" : "Tap to select"}
              </p>

            </div>
          );
        })}

      </div>

      {/* FOOTER */}
      <div className="text-center text-[10px] sm:text-xs text-gray-500 mt-8 pb-6">
        Prepared by {adminName} ({adminPhone})
      </div>

    </div>
  );
}