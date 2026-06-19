export function getUserId(): string | null {
  if (typeof window === "undefined") return null;
  return localStorage.getItem("userId");
}

export function getToken(): string | null {
  if (typeof window === "undefined") return null;
  return localStorage.getItem("token");
}

export function getRole(): string | null {
  if (typeof window === "undefined") return null;
  return localStorage.getItem("role");
}

export function setAuth(data: {
  userId: string;
  token: string;
  role: string;
}) {
  localStorage.setItem("userId", data.userId);
  localStorage.setItem("token", data.token);
  localStorage.setItem("role", data.role);
}

export function logout() {
  localStorage.removeItem("userId");
  localStorage.removeItem("token");
  localStorage.removeItem("role");

  window.location.href = "/auth/login";
}