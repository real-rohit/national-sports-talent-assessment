import { useState, useEffect } from 'react';
import { 
  collection, 
  getDocs, 
  doc, 
  getDoc,
  query, 
  where, 
  orderBy, 
  limit,
  onSnapshot,
  QueryConstraint,
  DocumentData,
  FirestoreError
} from 'firebase/firestore';
import { db } from '@/lib/firebase';

// Enhanced hook for single collection with real-time updates
export function useFirestoreCollection(collectionName: string, enableRealTime = false) {
  const [data, setData] = useState<DocumentData[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!db) {
      setError(new Error('Firestore is not initialized (missing VITE_ env vars)'));
      setLoading(false);
      return;
    }

    const collectionRef = collection(db, collectionName);

    if (enableRealTime) {
      // Real-time updates
      const unsubscribe = onSnapshot(
        collectionRef,
        (querySnapshot) => {
          const collectionData = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
          setData(collectionData);
          setLoading(false);
        },
        (err: FirestoreError) => {
          setError(err);
          setLoading(false);
        }
      );

      return () => unsubscribe();
    } else {
      // One-time fetch
      async function fetchData() {
        try {
          const querySnapshot = await getDocs(collectionRef);
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
    }
  }, [collectionName, enableRealTime]);

  return { data, loading, error };
}

// Hook for querying with filters
export function useFirestoreQuery(
  collectionName: string, 
  constraints: QueryConstraint[] = [],
  enableRealTime = false
) {
  const [data, setData] = useState<DocumentData[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      setLoading(false);
      return;
    }

    const q = query(collection(db, collectionName), ...constraints);

    if (enableRealTime) {
      const unsubscribe = onSnapshot(
        q,
        (querySnapshot) => {
          const queryData = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
          setData(queryData);
          setLoading(false);
        },
        (err: FirestoreError) => {
          setError(err);
          setLoading(false);
        }
      );

      return () => unsubscribe();
    } else {
      async function fetchData() {
        try {
          const querySnapshot = await getDocs(q);
          const queryData = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
          setData(queryData);
        } catch (err) {
          setError(err as Error);
        } finally {
          setLoading(false);
        }
      }

      fetchData();
    }
  }, [collectionName, constraints, enableRealTime]);

  return { data, loading, error };
}

// Hook for single document
export function useFirestoreDocument(collectionName: string, docId: string | null) {
  const [data, setData] = useState<DocumentData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!db || !docId) {
      setLoading(false);
      return;
    }

    async function fetchDocument() {
      try {
        const docRef = doc(db, collectionName, docId);
        const docSnap = await getDoc(docRef);
        
        if (docSnap.exists()) {
          setData({ id: docSnap.id, ...docSnap.data() });
        } else {
          setData(null);
        }
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }

    fetchDocument();
  }, [collectionName, docId]);

  return { data, loading, error };
}

// Specialized hooks for each collection
export function useAthletes(filters?: {
  state?: string;
  gender?: string;
  status?: string;
  academyId?: string;
  limit?: number;
}) {
  const constraints: QueryConstraint[] = [];
  
  if (filters?.state && filters.state !== 'all') {
    constraints.push(where('state', '==', filters.state));
  }
  if (filters?.gender && filters.gender !== 'all') {
    constraints.push(where('gender', '==', filters.gender));
  }
  if (filters?.status) {
    constraints.push(where('status', '==', filters.status));
  }
  if (filters?.academyId) {
    constraints.push(where('academyId', '==', filters.academyId));
  }
  if (filters?.limit) {
    constraints.push(limit(filters.limit));
  }

  return useFirestoreQuery('athletes', constraints);
}

export function useAssessments(filters?: {
  status?: string;
  athleteId?: string;
  testType?: string;
  academyId?: string;
  limit?: number;
}) {
  const constraints: QueryConstraint[] = [];
  
  if (filters?.status) {
    constraints.push(where('status', '==', filters.status));
  }
  if (filters?.athleteId) {
    constraints.push(where('athleteId', '==', filters.athleteId));
  }
  if (filters?.testType) {
    constraints.push(where('testType', '==', filters.testType));
  }
  if (filters?.academyId) {
    constraints.push(where('academyId', '==', filters.academyId));
  }
  
  // Default ordering by submission date (newest first)
  constraints.push(orderBy('submissionDate', 'desc'));
  
  if (filters?.limit) {
    constraints.push(limit(filters.limit));
  }

  return useFirestoreQuery('assessments', constraints);
}

export function useStates() {
  return useFirestoreCollection('states');
}

export function useSports() {
  return useFirestoreCollection('sports');
}

export function useDashboardMetrics() {
  return useFirestoreDocument('analytics', 'dashboard-metrics');
}

// Hook for multiple collections at once
export function useMultipleCollections(collections: string[]) {
  const [data, setData] = useState<{[key: string]: DocumentData[]}>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!db) {
      setError(new Error('Firestore is not initialized'));
      setLoading(false);
      return;
    }

    async function fetchAllCollections() {
      try {
        const promises = collections.map(async (collectionName) => {
          const querySnapshot = await getDocs(collection(db, collectionName));
          const collectionData = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
          return { [collectionName]: collectionData };
        });

        const results = await Promise.all(promises);
        const combinedData = results.reduce((acc, curr) => ({ ...acc, ...curr }), {});
        setData(combinedData);
      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }

    fetchAllCollections();
  }, [collections]);

  return { data, loading, error };
}

// Utility hook for analytics data
export function useAnalyticsData() {
  const [analyticsData, setAnalyticsData] = useState({
    performanceByState: [] as any[],
    performanceByGender: [] as any[],
    performanceByAge: [] as any[],
    testTypeDistribution: [] as any[]
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const { data: athletes, loading: athletesLoading } = useAthletes();
  const { data: assessments, loading: assessmentsLoading } = useAssessments();
  const { data: states, loading: statesLoading } = useStates();

  useEffect(() => {
    if (!athletesLoading && !assessmentsLoading && !statesLoading) {
      try {
        // Calculate performance by state
        const statePerformance = states?.map(state => {
          const stateAthletes = athletes?.filter(a => a.state === state.name) || [];
          const avgScore = stateAthletes.length > 0 
            ? stateAthletes.reduce((sum, athlete) => sum + (athlete.performance?.overallScore || 0), 0) / stateAthletes.length
            : 0;
          
          return {
            state: state.name,
            athletes: stateAthletes.length,
            avgScore: Math.round(avgScore * 10) / 10
          };
        }) || [];

        // Calculate gender distribution
        const maleAthletes = athletes?.filter(a => a.gender === 'Male').length || 0;
        const femaleAthletes = athletes?.filter(a => a.gender === 'Female').length || 0;
        const totalAthletes = maleAthletes + femaleAthletes;
        
        const genderDistribution = [
          { 
            gender: 'Male', 
            count: maleAthletes, 
            percentage: totalAthletes > 0 ? Math.round((maleAthletes / totalAthletes) * 100 * 10) / 10 : 0 
          },
          { 
            gender: 'Female', 
            count: femaleAthletes, 
            percentage: totalAthletes > 0 ? Math.round((femaleAthletes / totalAthletes) * 100 * 10) / 10 : 0 
          }
        ];

        // Calculate age distribution
        const ageGroups = [
          { range: '14-15', min: 14, max: 15 },
          { range: '16-17', min: 16, max: 17 },
          { range: '18-19', min: 18, max: 19 }
        ];

        const ageDistribution = ageGroups.map(group => {
          const count = athletes?.filter(a => a.age >= group.min && a.age <= group.max).length || 0;
          return {
            ageGroup: group.range,
            count,
            percentage: totalAthletes > 0 ? Math.round((count / totalAthletes) * 100 * 10) / 10 : 0
          };
        });

        // Calculate test type distribution
        const testTypes = ['Vertical Jump', 'Sit-ups', 'Shuttle Run', 'Flexibility'];
        const testDistribution = testTypes.map(testType => {
          const count = assessments?.filter(a => a.testType === testType).length || 0;
          const totalAssessments = assessments?.length || 0;
          return {
            name: testType,
            count,
            value: totalAssessments > 0 ? Math.round((count / totalAssessments) * 100) : 0
          };
        });

        setAnalyticsData({
          performanceByState: statePerformance,
          performanceByGender: genderDistribution,
          performanceByAge: ageDistribution,
          testTypeDistribution: testDistribution
        });

      } catch (err) {
        setError(err as Error);
      } finally {
        setLoading(false);
      }
    }
  }, [athletes, assessments, states, athletesLoading, assessmentsLoading, statesLoading]);

  return { 
    data: analyticsData, 
    loading: loading || athletesLoading || assessmentsLoading || statesLoading, 
    error 
  };
}
