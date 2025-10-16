import { useState } from 'react';
import { 
  collection, 
  doc, 
  addDoc, 
  updateDoc, 
  deleteDoc,
  writeBatch,
  serverTimestamp,
  DocumentData
} from 'firebase/firestore';
import { db } from '@/lib/firebase';

export interface CRUDOperations {
  creating: boolean;
  updating: boolean;
  deleting: boolean;
  error: Error | null;
  create: (data: any) => Promise<string | null>;
  update: (id: string, data: any) => Promise<boolean>;
  delete: (id: string) => Promise<boolean>;
  bulkDelete: (ids: string[]) => Promise<boolean>;
}

export function useFirebaseCRUD(collectionName: string): CRUDOperations {
  const [creating, setCreating] = useState(false);
  const [updating, setUpdating] = useState(false);
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const create = async (data: any): Promise<string | null> => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      return null;
    }

    setCreating(true);
    setError(null);
    
    try {
      const docRef = await addDoc(collection(db, collectionName), {
        ...data,
        createdAt: serverTimestamp(),
        updatedAt: serverTimestamp()
      });
      return docRef.id;
    } catch (err) {
      setError(err as Error);
      return null;
    } finally {
      setCreating(false);
    }
  };

  const update = async (id: string, data: any): Promise<boolean> => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      return false;
    }

    setUpdating(true);
    setError(null);
    
    try {
      const docRef = doc(db, collectionName, id);
      await updateDoc(docRef, {
        ...data,
        updatedAt: serverTimestamp()
      });
      return true;
    } catch (err) {
      setError(err as Error);
      return false;
    } finally {
      setUpdating(false);
    }
  };

  const deleteDocument = async (id: string): Promise<boolean> => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      return false;
    }

    setDeleting(true);
    setError(null);
    
    try {
      const docRef = doc(db, collectionName, id);
      await deleteDoc(docRef);
      return true;
    } catch (err) {
      setError(err as Error);
      return false;
    } finally {
      setDeleting(false);
    }
  };

  const bulkDelete = async (ids: string[]): Promise<boolean> => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      return false;
    }

    setDeleting(true);
    setError(null);
    
    try {
      const batch = writeBatch(db);
      
      ids.forEach(id => {
        const docRef = doc(db, collectionName, id);
        batch.delete(docRef);
      });
      
      await batch.commit();
      return true;
    } catch (err) {
      setError(err as Error);
      return false;
    } finally {
      setDeleting(false);
    }
  };

  return {
    creating,
    updating,
    deleting,
    error,
    create,
    update,
    delete: deleteDocument,
    bulkDelete
  };
}

// Specialized CRUD hooks for different collections

export function useAthletesCRUD() {
  return useFirebaseCRUD('athletes');
}

export function useAssessmentsCRUD() {
  return useFirebaseCRUD('assessments');
}

export function useUsersCRUD() {
  return useFirebaseCRUD('users');
}

// Hook for search functionality
export function useFirebaseSearch() {
  const [searching, setSearching] = useState(false);
  const [results, setResults] = useState<DocumentData[]>([]);
  const [error, setError] = useState<Error | null>(null);

  const searchAthletes = async (searchTerm: string, filters?: {
    state?: string;
    gender?: string;
    sport?: string;
  }) => {
    if (!db || !searchTerm.trim()) {
      setResults([]);
      return;
    }

    setSearching(true);
    setError(null);

    try {
      // Note: Firestore doesn't support full-text search natively.
      // For production, consider using Algolia or Elasticsearch.
      // This is a basic implementation using startAt/endAt for name search
      
      const searchTermLower = searchTerm.toLowerCase();
      const searchTermUpper = searchTermLower + '\uf8ff';
      
      // We would need to implement actual search logic here
      // For now, return empty results
      setResults([]);
      
    } catch (err) {
      setError(err as Error);
    } finally {
      setSearching(false);
    }
  };

  return {
    searching,
    results,
    error,
    searchAthletes
  };
}

// Export validation helpers
export const validateAthlete = (data: any): { isValid: boolean; errors: string[] } => {
  const errors: string[] = [];
  
  if (!data.name?.trim()) errors.push('Name is required');
  if (!data.age || data.age < 14 || data.age > 25) errors.push('Age must be between 14 and 25');
  if (!data.gender) errors.push('Gender is required');
  if (!data.state?.trim()) errors.push('State is required');
  if (!data.district?.trim()) errors.push('District is required');
  if (!data.phoneNumber?.trim()) errors.push('Phone number is required');
  
  return {
    isValid: errors.length === 0,
    errors
  };
};

export const validateAssessment = (data: any): { isValid: boolean; errors: string[] } => {
  const errors: string[] = [];
  
  if (!data.athleteId?.trim()) errors.push('Athlete ID is required');
  if (!data.testType?.trim()) errors.push('Test type is required');
  if (!data.performanceMetric || data.performanceMetric <= 0) errors.push('Performance metric is required');
  if (!data.aiScore || data.aiScore < 0 || data.aiScore > 100) errors.push('AI Score must be between 0 and 100');
  
  return {
    isValid: errors.length === 0,
    errors
  };
};
