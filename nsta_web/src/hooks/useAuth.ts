import { useState, useEffect } from 'react';
import { onAuthStateChanged, User } from 'firebase/auth';
import { doc, getDoc } from 'firebase/firestore';
import { auth, db } from '@/lib/firebase';

interface UserData {
  name: string;
  email: string;
  role: 'official' | 'academy';
  phone?: string;
  sport?: string;
  userId?: string;
  height?: string;
  weight?: string;
  academyId?: string;
  academyName?: string;
  createdAt?: any;
  updatedAt?: any;
}

export function useAuth() {
  const [user, setUser] = useState<User | null>(null);
  const [userRole, setUserRole] = useState<string | null>(null);
  const [userData, setUserData] = useState<UserData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Check for demo user first
    const demoUserData = localStorage.getItem('demoUser');
    if (demoUserData) {
      try {
        const demoUser = JSON.parse(demoUserData);
        // Create a mock user object for demo users
        const mockUser = {
          uid: demoUser.uid,
          email: demoUser.email,
          emailVerified: true,
        } as User;
        
        setUser(mockUser);
        setUserRole(demoUser.role);
        
        // Set appropriate user data based on role
        if (demoUser.role === 'official') {
          setUserData({
            name: demoUser.email === 'rohit@gmail.com' ? 'Rohit' : 'SAI Official',
            email: demoUser.email,
            role: 'official',
            phone: demoUser.email === 'rohit@gmail.com' ? '+917597181771' : '+91-9876543210',
            sport: demoUser.email === 'rohit@gmail.com' ? 'football' : 'athletics',
            userId: demoUser.email === 'rohit@gmail.com' ? '807954' : demoUser.uid,
            height: demoUser.email === 'rohit@gmail.com' ? '178' : '175',
            weight: demoUser.email === 'rohit@gmail.com' ? '64' : '70'
          });
        } else if (demoUser.role === 'academy') {
          setUserData({
            name: 'Academy Admin',
            email: demoUser.email,
            role: 'academy',
            phone: '+91-9876543210',
            sport: 'multi-sport',
            userId: demoUser.uid,
            height: '170',
            weight: '65',
            academyId: 'academy_001',
            academyName: 'Delhi Sports Academy'
          });
        }
        
        setLoading(false);
        return;
      } catch (error) {
        console.error('Error parsing demo user data:', error);
        localStorage.removeItem('demoUser');
      }
    }

    // If Firebase `auth` is not initialized (e.g. env vars not set), avoid calling onAuthStateChanged
    if (!auth) {
      setUser(null);
      setUserRole(null);
      setUserData(null);
      setLoading(false);
      return;
    }

    const unsubscribe = onAuthStateChanged(auth, async (user) => {
      if (user && db) {
        try {
          // Try to get user data from Firestore
          const userDoc = await getDoc(doc(db, 'users', user.uid));
          if (userDoc.exists()) {
            const data = userDoc.data() as UserData;
            setUserRole(data.role);
            setUserData(data);
          } else {
            // For demo purposes, set default data for seeded user
            const officialEmails = ['rohit@gmail.com', 'admin@sai.gov.in', 'official@nsta.gov.in'];
            const academyEmails = ['aman@nsta.gov.in', 'academy2@sai.gov.in', 'coach@academy.com'];
            
            if (officialEmails.includes(user.email || '')) {
              setUserRole('official');
              setUserData({
                name: user.email === 'rohit@gmail.com' ? 'Rohit' : 'SAI Official',
                email: user.email || '',
                role: 'official',
                phone: user.email === 'rohit@gmail.com' ? '+917597181771' : '+91-9876543210',
                sport: user.email === 'rohit@gmail.com' ? 'football' : 'athletics',
                userId: user.email === 'rohit@gmail.com' ? '807954' : user.uid,
                height: user.email === 'rohit@gmail.com' ? '178' : '175',
                weight: user.email === 'rohit@gmail.com' ? '64' : '70'
              });
            } else if (academyEmails.includes(user.email || '')) {
              setUserRole('academy');
              setUserData({
                name: 'Academy Admin',
                email: user.email || '',
                role: 'academy',
                phone: '+91-9876543210',
                sport: 'multi-sport',
                userId: user.uid,
                height: '170',
                weight: '65',
                academyId: 'academy_001', // Academy identifier for filtering
                academyName: 'Delhi Sports Academy'
              });
            } else {
              setUserRole(null);
              setUserData(null);
            }
          }
        } catch (error) {
          console.error('Error fetching user data:', error);
          setUserRole(null);
          setUserData(null);
        }
      } else {
        setUserRole(null);
        setUserData(null);
      }
      setUser(user);
      setLoading(false);
    });

    return () => {
      if (typeof unsubscribe === 'function') unsubscribe();
    };
  }, []);

  return { user, userRole, userData, loading };
}
