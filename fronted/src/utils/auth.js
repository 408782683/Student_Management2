const STORAGE_KEY = 'as_user';

export function setUser(user) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(user || {}));
}

export function getUser() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
}

export function clearUser() {
  localStorage.removeItem(STORAGE_KEY);
}
