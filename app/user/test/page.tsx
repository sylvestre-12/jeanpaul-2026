"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { useLanguage } from "@/i18n/LanguageProvider";

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

type QuestionTranslation = {
  language: Language;
  text: string;
};

type Question = {
  id: number;
  image?: string | null;
  translations: QuestionTranslation[];
  options: Option[];
};

const STORAGE_KEY = "user-exam-session-v1";

export default function UserExamPage() {
 
  const { lang, setLang } = useLanguage();

  const [userName, setUserName] = useState<string>("");
  const [userPhone, setUserPhone] = useState<string>("");

  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState(true);

  const [countdown, setCountdown] = useState(5);
  const [started, setStarted] = useState(false);

  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<number, number>>({});

  const [timeLeft, setTimeLeft] = useState(20 * 60);

  const [finished, setFinished] = useState(false);
  const [score, setScore] = useState(0);

  const timerRef = useRef<NodeJS.Timeout | null>(null);

  // ================= USER INFO =================


useEffect(() => {
  const savedLang =
    localStorage.getItem("app_lang") ||
    localStorage.getItem("language") ||
    localStorage.getItem("lang");

  if (savedLang) {
    setLang(savedLang as Language);
  }

  setUserName(localStorage.getItem("userName") || "User");
  setUserPhone(localStorage.getItem("userPhone") || "");
}, [setLang]);
  // ================= LOAD QUESTIONS =================
  useEffect(() => {
    async function loadQuestions() {
      try {
        const res = await fetch("/api/user/test");
        const data = await res.json();

        const shuffled = [...data].sort(() => Math.random() - 0.5);
        const selected = shuffled.slice(0, 20);

        const randomized = selected.map((q: Question) => ({
          ...q,
          options: [...q.options].sort(() => Math.random() - 0.5),
        }));

        setQuestions(randomized);

        const saved = localStorage.getItem(STORAGE_KEY);

        if (saved) {
          const parsed = JSON.parse(saved);
          setAnswers(parsed.answers || {});
          setCurrentIndex(parsed.currentIndex || 0);
          setTimeLeft(parsed.timeLeft ?? 20 * 60);
          setStarted(true);
        }
      } finally {
        setLoading(false);
      }
    }

    loadQuestions();
  }, []);

  // ================= AUTO SAVE =================
  useEffect(() => {
    if (!started || finished) return;

    localStorage.setItem(
      STORAGE_KEY,
      JSON.stringify({
        answers,
        currentIndex,
        timeLeft,
      })
    );
  }, [answers, currentIndex, timeLeft, started, finished]);

  // ================= COUNTDOWN =================
  useEffect(() => {
    if (loading || started) return;

    if (countdown <= 0) {
      setStarted(true);
      return;
    }

    const t = setTimeout(() => setCountdown((p) => p - 1), 1000);
    return () => clearTimeout(t);
  }, [countdown, loading, started]);

  // ================= TIMER =================
  useEffect(() => {
    if (!started || finished) return;

    if (timeLeft <= 0) {
      finishExam();
      return;
    }

    timerRef.current = setInterval(() => {
      setTimeLeft((p) => p - 1);
    }, 1000);

    return () => {
      if (timerRef.current) clearInterval(timerRef.current);
    };
  }, [started, timeLeft, finished]);

  // ================= FINISH =================
  async function finishExam() {
    let total = 0;
    const answerList: any[] = [];

    questions.forEach((q) => {
      const selected = answers[q.id];
      const correct = q.options.find((o) => o.isCorrect);

      if (correct && selected === correct.id) total++;

      if (selected) {
        answerList.push({
          questionId: q.id,
          optionId: selected,
        });
      }
    });

    setScore(total);
    setFinished(true);
    localStorage.removeItem(STORAGE_KEY);

    const userId = localStorage.getItem("userId");

    await fetch("/api/exam/submit", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        userId,
        score: total,
        total: questions.length,
        answers: answerList,
      }),
    });

    setTimeout(() => {
      window.location.href = "/user/dashboard";
    }, 3000);
  }

  function selectAnswer(questionId: number, optionId: number) {
    setAnswers((prev) => ({ ...prev, [questionId]: optionId }));
  }

  function nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex((p) => p + 1);
    } else {
      finishExam();
    }
  }

  function previousQuestion() {
    if (currentIndex > 0) setCurrentIndex((p) => p - 1);
  }

  const formattedTime = useMemo(() => {
    const m = Math.floor(timeLeft / 60);
    const s = timeLeft % 60;
    return `${m}:${s.toString().padStart(2, "0")}`;
  }, [timeLeft]);

  function getQuestionText(q: Question) {
    return (
      q.translations.find((t) => t.language === lang)?.text ||
      "No translation"
    );
  }

  function getOptionText(o: Option) {
    return (
      o.translations.find((t) => t.language === lang)?.text ||
      "No translation"
    );
  }

  // ================= LOADING =================
  if (loading) {
    return (
      <div className="h-screen flex items-center justify-center font-bold">
        Loading Questions...
      </div>
    );
  }

  // ================= COUNTDOWN =================
  if (!started) {
    return (
      <div className="h-screen flex flex-col items-center justify-center">
        <h1 className="text-3xl font-bold mb-2">Exam Starts In</h1>

        {/* USER INFO */}
        <div className="mb-4 text-center text-gray-600">
          <p>👤 {userName}</p>
          <p>📱 {userPhone}</p>
          <p>🌍 {lang}</p>
        </div>

        <div className="text-7xl font-bold text-blue-600">{countdown}</div>
      </div>
    );
  }

  // ================= RESULT =================
  if (finished) {
    return (
      <div className="h-screen flex flex-col items-center justify-center text-center">
        <h1 className="text-3xl font-bold mb-4">Final Result</h1>

        <div className="text-6xl font-bold mb-4">
          {score} / {questions.length}
        </div>

        <div className="text-gray-600 mb-2">
          👤 {userName} | 📱 {userPhone}
        </div>

        <div
          className={`text-2xl font-bold ${
            score >= 12 ? "text-green-600" : "text-red-600"
          }`}
        >
          {score >= 12 ? "🎉 Great Performance" : "Keep Practicing"}
        </div>

        <p className="mt-4 text-gray-500">
          Redirecting...
        </p>
      </div>
    );
  }

  const question = questions[currentIndex];

  // ================= UI =================
  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">

      {/* TOP BAR */}
      <div className="sticky top-0 bg-white shadow p-3 flex justify-between">
        <div className="font-bold">
          👤 {userName}
        </div>

        <div className="text-sm text-gray-600">
          📱 {userPhone} | 🌍 {lang}
        </div>

        <div className="text-red-600 font-bold">⏱ {formattedTime}</div>
      </div>

      {/* QUESTION */}
      <div className="flex-1 flex justify-center px-4 py-6 pb-20">
        <div className="w-full max-w-3xl bg-white rounded-xl shadow p-5">

          <h2 className="text-lg font-semibold mb-4">
            {currentIndex + 1}. {getQuestionText(question)}
          </h2>

          {question.image && (
            <img
              src={question.image}
              className="w-full max-h-[280px] object-contain mb-4 rounded"
            />
          )}

          <div className="space-y-3">
            {question.options.map((option, index) => (
              <button
                key={option.id}
                onClick={() => selectAnswer(question.id, option.id)}
                className={`w-full text-left p-4 border rounded ${
                  answers[question.id] === option.id
                    ? "bg-blue-600 text-white"
                    : "hover:bg-gray-100"
                }`}
              >
                <b>{String.fromCharCode(65 + index)}.</b>{" "}
                {getOptionText(option)}
              </button>
            ))}
          </div>

          {/* NAV */}
          <div className="flex justify-between mt-6 pt-4 border-t">

            <button
              onClick={previousQuestion}
              disabled={currentIndex === 0}
              className="px-5 py-3 bg-gray-500 text-white rounded disabled:opacity-50"
            >
              Previous
            </button>

            <button
              onClick={finishExam}
              className="px-6 py-3 bg-red-600 text-white rounded font-bold"
            >
              Finish
            </button>

            <button
              onClick={nextQuestion}
              className="px-5 py-3 bg-blue-600 text-white rounded"
            >
              Next
            </button>

          </div>

        </div>
      </div>

    </div>
  );
}