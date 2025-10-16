import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

// Helper to check that all required VITE_ env vars are set
const hasFirebaseEnv = () => {
  const required = [
    'VITE_API_KEY',
    'VITE_AUTH_DOMAIN',
    'VITE_PROJECT_ID',
    'VITE_STORAGE_BUCKET',
    'VITE_MESSAGING_SENDER_ID',
    'VITE_APP_ID',
  ];

  return required.every((k) => typeof (import.meta.env as any)[k] === 'string' && (import.meta.env as any)[k].length > 0);
};

let app = null as any;
let auth = null as any;
let db = null as any;

if (hasFirebaseEnv()) {
  const firebaseConfig = {
    apiKey: import.meta.env.VITE_API_KEY,
    authDomain: import.meta.env.VITE_AUTH_DOMAIN,
    projectId: import.meta.env.VITE_PROJECT_ID,
    storageBucket: import.meta.env.VITE_STORAGE_BUCKET,
    messagingSenderId: import.meta.env.VITE_MESSAGING_SENDER_ID,
    appId: import.meta.env.VITE_APP_ID,
    measurementId: import.meta.env.VITE_MEASUREMENT_ID,
  };

  try {
    app = initializeApp(firebaseConfig);
    auth = getAuth(app);
    db = getFirestore(app);
  } catch (err) {
    // If initialization fails, log a helpful message and keep exports null so app won't crash
    // eslint-disable-next-line no-console
    console.error('[firebase] failed to initialize:', err);
  }
} else {
  // eslint-disable-next-line no-console
  console.warn('[firebase] VITE_ environment variables are not set. Firebase will not be initialized.');
}

export { app, auth, db };