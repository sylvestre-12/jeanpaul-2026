"use client";

import { useEffect, useState } from "react";


type User = {
  id: number;
  name: string | null;
  phone: string;
  role: string;
  approved: boolean;
  createdAt: string;
};
// =========================
// 20 DAYS COUNTDOWN
// =========================

const [remainingTime, setRemainingTime] = useState<number | null>(null);

const COUNTDOWN_KEY = "admin-system-expiration";
const TOTAL_TIME = 20 * 24 * 60 * 60 * 1000;

export default function AdminUsersPage() {

  const [users, setUsers] = useState<User[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  // sorting
  const [sortBy, setSortBy] =
    useState("time");

  // edit
  const [editingId, setEditingId] =
    useState<number | null>(null);

  const [editName, setEditName] =
    useState("");

  const [editPhone, setEditPhone] =
    useState("");

  // =========================
  // FETCH USERS
  // =========================
  async function fetchUsers() {

    try {

      const res = await fetch(
        "/api/admin/users"
      );

      const data = await res.json();

      setUsers(data);

    } catch (error) {

      console.error(error);

    } finally {

      setLoading(false);
    }
  }

  useEffect(() => {
    fetchUsers();
  }, []);

  // =========================
  // TOGGLE APPROVAL
  // =========================
  async function toggleApproval(
    id: number,
    current: boolean
  ) {

    try {

      await fetch(
        "/api/admin/users",
        {
          method: "PATCH",
          headers: {
            "Content-Type":
              "application/json",
          },
          body: JSON.stringify({
            id,
            approved: !current,
          }),
        }
      );

      fetchUsers();

    } catch (error) {

      console.error(error);
    }
  }
// =========================
// COUNTDOWN LOGIC
// =========================

useEffect(() => {
  let expirationTime: number;

  const savedTime = localStorage.getItem(COUNTDOWN_KEY);

  if (savedTime) {
    expirationTime = Number(savedTime);
  } else {
    expirationTime = Date.now() + TOTAL_TIME;

    localStorage.setItem(
      COUNTDOWN_KEY,
      expirationTime.toString()
    );
  }

  function updateCountdown() {
    const remaining = Math.max(0, expirationTime - Date.now());
    setRemainingTime(remaining);
  }

  updateCountdown();

  const interval = setInterval(updateCountdown, 1000);

  return () => clearInterval(interval);
}, []);
  // =========================
  // DELETE USER
  // =========================
  async function deleteUser(
    id: number
  ) {

    const confirmDelete =
      confirm(
        "Delete this user?"
      );

    if (!confirmDelete) return;

    try {

      await fetch(
        `/api/admin/users?id=${id}`,
        {
          method: "DELETE",
        }
      );

      fetchUsers();

    } catch (error) {

      console.error(error);
    }
  }

  // =========================
  // START EDIT
  // =========================
  function startEdit(user: User) {

    setEditingId(user.id);

    setEditName(user.name || "");

    setEditPhone(user.phone);
  }

  // =========================
  // CANCEL EDIT
  // =========================
  function cancelEdit() {

    setEditingId(null);

    setEditName("");

    setEditPhone("");
  }

  // =========================
  // SAVE EDIT
  // =========================
  async function saveEdit(
    id: number
  ) {

    try {

      const res = await fetch(
        "/api/admin/users/edit",
        {
          method: "PUT",
          headers: {
            "Content-Type":
              "application/json",
          },
          body: JSON.stringify({
            id,
            name: editName,
            phone: editPhone,
          }),
        }
      );

      if (!res.ok) {
        alert("Failed to update user");
        return;
      }

      cancelEdit();

      fetchUsers();

    } catch (error) {

      console.error(error);
    }
  }

  // =========================
  // RESET SEARCH
  // =========================
  function resetSearch() {

    setSearch("");
  }

  // =========================
  // FILTER + SORT
  // =========================
  const filteredUsers =
    users
      .filter((user) => {

        const value =
          search.toLowerCase();

        return (
          user.phone
            .toLowerCase()
            .includes(value) ||

          user.name
            ?.toLowerCase()
            .includes(value)
        );
      })

      .sort((a, b) => {

        if (sortBy === "id") {
          return a.id - b.id;
        }

        return (
          new Date(
            b.createdAt
          ).getTime() -
          new Date(
            a.createdAt
          ).getTime()
        );
      });

  // =========================
  // UI
  // =========================
  return (
    <div className="p-6">

      <h1 className="text-3xl font-bold mb-6">
        Admin Users Management
      </h1>

      {/* SEARCH + SORT */}
      <div className="flex flex-wrap gap-3 mb-6">

        {/* SEARCH */}
        <input
          type="text"
          placeholder="Search users..."
          className="flex-1 border p-3 rounded"
          value={search}
          onChange={(e) =>
            setSearch(e.target.value)
          }
        />

        {/* SORT */}
        <select
          value={sortBy}
          onChange={(e) =>
            setSortBy(
              e.target.value
            )
          }
          className="border p-3 rounded"
        >
          <option value="time">
            Sort By Time
          </option>

          <option value="id">
            Sort By ID
          </option>
        </select>

        {/* RESET */}
        <button
          onClick={resetSearch}
          className="bg-gray-700 text-white px-5 rounded"
        >
          Reset
        </button>

      </div>

      {/* LOADING */}
      {loading && (
        <p>Loading users...</p>
      )}

      {/* TABLE */}
      {!loading && (

        <div className="overflow-x-auto">

          <table className="w-full border">

            <thead className="bg-gray-200">

              <tr>

                <th className="border p-3">
                  ID
                </th>

                <th className="border p-3">
                  Name
                </th>

                <th className="border p-3">
                  Phone
                </th>

                <th className="border p-3">
                  Role
                </th>

                <th className="border p-3">
                  Approved
                </th>

                <th className="border p-3">
                  Created
                </th>

                <th className="border p-3">
                  Actions
                </th>

              </tr>

            </thead>

            <tbody>

              {filteredUsers.map(
                (user) => (

                <tr key={user.id}>

                  {/* ID */}
                  <td className="border p-3">
                    {user.id}
                  </td>

                  {/* NAME */}
                  <td className="border p-3">

                    {editingId ===
                    user.id ? (

                      <input
                        value={editName}
                        onChange={(e) =>
                          setEditName(
                            e.target.value
                          )
                        }
                        className="border p-2 rounded w-full"
                      />

                    ) : (
                      user.name || "-"
                    )}

                  </td>

                  {/* PHONE */}
                  <td className="border p-3">

                    {editingId ===
                    user.id ? (

                      <input
                        value={editPhone}
                        onChange={(e) =>
                          setEditPhone(
                            e.target.value
                          )
                        }
                        className="border p-2 rounded w-full"
                      />

                    ) : (
                      user.phone
                    )}

                  </td>

                  {/* ROLE */}
                  <td className="border p-3">
                    {user.role}
                  </td>

                  {/* APPROVED */}
                  <td className="border p-3">

                    <button
                      onClick={() =>
                        toggleApproval(
                          user.id,
                          user.approved
                        )
                      }
                      className={`px-3 py-1 rounded text-white ${
                        user.approved
                          ? "bg-green-600"
                          : "bg-gray-700"
                      }`}
                    >
                      {user.approved
                        ? "Approved"
                        : "Not Approved"}
                    </button>

                  </td>

                  {/* CREATED */}
                  <td className="border p-3">

                    {new Date(
                      user.createdAt
                    ).toLocaleString()}

                  </td>

                  {/* ACTIONS */}
                  <td className="border p-3">

                    <div className="flex gap-2 flex-wrap">

                      {editingId !==
                      user.id ? (

                        <button
                          onClick={() =>
                            startEdit(
                              user
                            )
                          }
                          className="bg-blue-600 text-white px-3 py-1 rounded"
                        >
                          Edit
                        </button>

                      ) : (

                        <>
                          <button
                            onClick={() =>
                              saveEdit(
                                user.id
                              )
                            }
                            className="bg-indigo-600 text-white px-3 py-1 rounded"
                          >
                            Save
                          </button>

                          <button
                            onClick={
                              cancelEdit
                            }
                            className="bg-gray-600 text-white px-3 py-1 rounded"
                          >
                            Cancel
                          </button>
                        </>

                      )}

                      {/* DELETE */}
                      <button
                        onClick={() =>
                          deleteUser(
                            user.id
                          )
                        }
                        className="bg-red-600 text-white px-3 py-1 rounded"
                      >
                        Delete
                      </button>

                    </div>

                  </td>

                </tr>

              ))}

            </tbody>

          </table>

        </div>

      )}
      {/* ========================= */}
{/* FIXED 20 DAYS COUNTER */}
{/* ========================= */}

{remainingTime !== null && (
  <div className="fixed right-5 top-1/2 -translate-y-1/2 z-[9999] bg-gray-950 text-white border border-red-500 shadow-2xl rounded-2xl p-5 w-64">

    <div className="flex items-center gap-2 mb-3">
      <span className="text-2xl">⚠️</span>

      <h2 className="font-bold text-red-400">
        System Countdown
      </h2>
    </div>

    <p className="text-sm text-gray-300 mb-4">
      This system will disappear in
    </p>

    {remainingTime > 0 ? (
      <div className="grid grid-cols-4 gap-2 text-center">

        {/* DAYS */}
        <div className="bg-gray-800 p-2 rounded-lg">
          <div className="text-xl font-bold">
            {Math.floor(remainingTime / (1000 * 60 * 60 * 24))}
          </div>
          <div className="text-xs text-gray-400">Days</div>
        </div>

        {/* HOURS */}
        <div className="bg-gray-800 p-2 rounded-lg">
          <div className="text-xl font-bold">
            {Math.floor((remainingTime / (1000 * 60 * 60)) % 24)
              .toString()
              .padStart(2, "0")}
          </div>
          <div className="text-xs text-gray-400">Hours</div>
        </div>

        {/* MINUTES */}
        <div className="bg-gray-800 p-2 rounded-lg">
          <div className="text-xl font-bold">
            {Math.floor((remainingTime / (1000 * 60)) % 60)
              .toString()
              .padStart(2, "0")}
          </div>
          <div className="text-xs text-gray-400">Min</div>
        </div>

        {/* SECONDS */}
        <div className="bg-gray-800 p-2 rounded-lg">
          <div className="text-xl font-bold">
            {Math.floor((remainingTime / 1000) % 60)
              .toString()
              .padStart(2, "0")}
          </div>
          <div className="text-xs text-gray-400">Sec</div>
        </div>

      </div>
    ) : (
      <div className="text-red-500 font-bold text-xl">
        Time expired
      </div>
    )}

    <div className="mt-4 border-t border-gray-700 pt-3 text-xs text-gray-400">
      Remaining system lifetime
    </div>

  </div>
)}

    </div>
  );
}