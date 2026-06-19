"use client";

import { useRouter } from "next/navigation";

type Language = "EN" | "FR" | "RW";

type Question = {
  id: number;
  image?: string | null;
  translations: {
    language: Language;
    text: string;
  }[];
};

export default function QuestionTable({
  questions,
  lang,
}: {
  questions: Question[];
  lang: Language;
}) {
  const router = useRouter();

  return (
    <div className="grid gap-4">

      {questions.map((q) => {
        const text =
          q.translations.find((t) => t.language === lang)?.text || "-";

        return (
          <div
            key={q.id}
            className="border rounded-lg p-4 bg-white shadow-sm"
          >

            <div className="flex gap-4">

              {/* IMAGE */}
              <div>
                {q.image ? (
                  <img
                    src={q.image}
                    className="w-20 h-20 rounded object-cover"
                  />
                ) : (
                  <div className="w-20 h-20 bg-gray-100 flex items-center justify-center text-gray-400 text-xs">
                    No Image
                  </div>
                )}
              </div>

              {/* QUESTION */}
              <div className="flex-1">
                <p className="text-sm font-semibold">
                  ID: {q.id}
                </p>

                <p className="mt-1 text-sm">
                  {text}
                </p>
              </div>
            </div>

            {/* ACTIONS */}
            <div className="mt-3 flex gap-2">

              <button
                onClick={() =>
                  router.push(`/admin/questions/edit/${q.id}`)
                }
                className="bg-blue-600 text-white px-3 py-1 rounded"
              >
                Edit
              </button>

              <button
                onClick={() =>
                  fetch(`/api/admin/questions/${q.id}`, {
                    method: "DELETE",
                  }).then(() => router.refresh())
                }
                className="bg-red-600 text-white px-3 py-1 rounded"
              >
                Delete
              </button>

            </div>

          </div>
        );
      })}

    </div>
  );
}