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

  const handleDelete = async (id: number) => {
    const confirmDelete = confirm(
      "Are you sure you want to delete this question?"
    );
    if (!confirmDelete) return;

    try {
      await fetch(`/api/admin/questions/${id}`, {
        method: "DELETE",
      });

      router.refresh();
    } catch (error) {
      console.error("Delete failed:", error);
    }
  };

  return (
    <div className="w-full grid gap-4 sm:gap-5">
      {questions.map((q) => {
        const text =
          q.translations.find((t) => t.language === lang)?.text || "-";

        return (
          <div
            key={q.id}
            className="
              w-full
              bg-white
              border border-gray-200
              rounded-2xl
              p-4 sm:p-5 md:p-6
              shadow-sm hover:shadow-md
              transition
            "
          >
            {/* TOP SECTION */}
            <div className="flex gap-3 sm:gap-4">

              {/* IMAGE */}
              <div className="shrink-0">
                {q.image ? (
                  <img
                    src={q.image}
                    alt={`Question ${q.id}`}
                    className="
                      w-16 h-16 sm:w-20 sm:h-20 md:w-24 md:h-24
                      rounded-xl
                      object-cover
                      border border-gray-100
                    "
                  />
                ) : (
                  <div
                    className="
                      w-16 h-16 sm:w-20 sm:h-20 md:w-24 md:h-24
                      rounded-xl
                      bg-gray-100
                      flex items-center justify-center
                      text-gray-400 text-xs
                      border border-gray-200
                    "
                  >
                    No Image
                  </div>
                )}
              </div>

              {/* TEXT CONTENT */}
              <div className="flex-1 min-w-0">
                <p className="text-xs sm:text-sm text-gray-500 font-medium">
                  Question ID: {q.id}
                </p>

                <p className="mt-1 text-sm sm:text-base md:text-[15px] text-gray-800 leading-7">
                  {text}
                </p>
              </div>
            </div>

            {/* ACTIONS */}
            <div className="mt-4 flex flex-wrap gap-2">

              <button
                onClick={() =>
                  router.push(`/admin/questions/edit/${q.id}`)
                }
                aria-label={`Edit question ${q.id}`}
                className="
                  min-h-[44px]
                  px-4 py-2
                  text-sm sm:text-base
                  font-semibold
                  bg-blue-600 text-white
                  rounded-xl
                  hover:bg-blue-700
                  transition
                  focus:outline-none focus:ring-2 focus:ring-blue-400
                "
              >
                Edit
              </button>

              <button
                onClick={() => handleDelete(q.id)}
                aria-label={`Delete question ${q.id}`}
                className="
                  min-h-[44px]
                  px-4 py-2
                  text-sm sm:text-base
                  font-semibold
                  bg-red-500 text-white
                  rounded-xl
                  hover:bg-red-600
                  transition
                  focus:outline-none focus:ring-2 focus:ring-red-300
                "
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