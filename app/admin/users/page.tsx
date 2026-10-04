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

    </div>
  );
}