const STORAGE_KEY = 'as_user';

export function setUser(user) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(user || {}));
}

export function setPasswordCache(username, password) {
  localStorage.setItem(`${STORAGE_KEY}_cred`, JSON.stringify({ username, password }));
}

export function getPasswordCache() {
  try {
    const raw = localStorage.getItem(`${STORAGE_KEY}_cred`);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
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
