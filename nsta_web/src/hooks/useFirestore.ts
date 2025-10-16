import { useState, useEffect } from 'react';
import { collection, getDocs, QuerySnapshot, DocumentData } from 'firebase/firestore';
import { db } from '@/lib/firebase';

export function useFirestore(collectionName: string) {
  const [data, setData] = useState<DocumentData[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    async function fetchData() {
      try {
        if (!db) {
          throw new Error('Firestore is not initialized (missing VITE_ env vars)');
        }

        const querySnapshot: QuerySnapshot<DocumentData> = await getDocs(collection(db, collectionName));
        const collectionData = querySnapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));
        setData(collectionData);
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }

    fetchData();
  }, [collectionName]);

  return { data, loading, error };
}