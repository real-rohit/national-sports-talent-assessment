import { collection, doc, writeBatch, getDocs } from 'firebase/firestore';
import { db } from './firebase';

// Types based on the existing mock data structure
interface Athlete {
  id: string;
  name: string;
  age: number;
  gender: 'Male' | 'Female';
  state: string;
  district: string;
  sportInterest: string[];
  registrationDate: string;
  lastAssessment: string;
  status: 'Active' | 'Pending' | 'Flagged';
  phoneNumber: string;
  performance: {
    verticalJump: number;
    sitUps: number;
    shuttleRun: number;
    flexibility: number;
    overallScore: number;
  };
  benchmarkStatus: 'Above' | 'At' | 'Below';
  email?: string;
  address?: string;
  coachName?: string;
  medicalClearance: boolean;
  createdAt: Date;
  updatedAt: Date;
}

interface Assessment {
  id: string;
  athleteId: string;
  athleteName: string;
  testType: 'Vertical Jump' | 'Sit-ups' | 'Shuttle Run' | 'Flexibility';
  submissionDate: string;
  status: 'Approved' | 'Pending' | 'Flagged' | 'Rejected';
  aiScore: number;
  reviewerNotes?: string;
  videoUrl?: string;
  cheatDetected: boolean;
  performanceMetric: number;
  reviewerId?: string;
  reviewDate?: string;
  createdAt: Date;
  updatedAt: Date;
}

interface DashboardMetrics {
  totalAthletes: number;
  pendingAssessments: number;
  verifiedAssessments: number;
  flaggedAssessments: number;
  monthlyGrowth: string;
  approvalRate: string;
  avgProcessingTime: string;
  topPerformingState: string;
  lastUpdated: Date;
}

interface StateData {
  id: string;
  name: string;
  athletes: number;
  avgScore: number;
  districts: string[];
  createdAt: Date;
}

interface SportData {
  id: string;
  name: string;
  category: string;
  description: string;
  assessmentTypes: string[];
  benchmarks: {
    male: { [key: string]: { excellent: number; good: number; average: number } };
    female: { [key: string]: { excellent: number; good: number; average: number } };
  };
  createdAt: Date;
}

// Sample data generators
const generateAthletes = (): Omit<Athlete, 'createdAt' | 'updatedAt'>[] => {
  const names = [
    'Arjun Kumar', 'Priya Sharma', 'Rohit Singh', 'Anjali Devi', 'Vikash Yadav',
    'Sneha Patel', 'Rajesh Gupta', 'Pooja Reddy', 'Amit Verma', 'Kavya Nair',
    'Suresh Kumar', 'Meera Joshi', 'Karan Singh', 'Ritu Agarwal', 'Dev Sharma',
    'Anita Rani', 'Harsh Patel', 'Deepika Singh', 'Nikhil Jain', 'Swati Dubey',
    'Ramesh Yadav', 'Sonal Gupta', 'Aakash Sharma', 'Neha Singh', 'Puneet Kumar',
    'Shreya Mishra', 'Gaurav Singh', 'Manisha Rao', 'Sahil Agarwal', 'Divya Patel'
  ];

  const states = [
    { name: 'Punjab', districts: ['Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala', 'Bathinda'] },
    { name: 'Haryana', districts: ['Gurugram', 'Faridabad', 'Panipat', 'Ambala', 'Karnal'] },
    { name: 'Kerala', districts: ['Kochi', 'Thiruvananthapuram', 'Kozhikode', 'Thrissur', 'Kollam'] },
    { name: 'Rajasthan', districts: ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer'] },
    { name: 'Tamil Nadu', districts: ['Chennai', 'Coimbatore', 'Madurai', 'Salem', 'Tiruchirappalli'] },
    { name: 'Maharashtra', districts: ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad'] },
    { name: 'Karnataka', districts: ['Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum'] },
    { name: 'Uttar Pradesh', districts: ['Lucknow', 'Kanpur', 'Agra', 'Varanasi', 'Meerut'] }
  ];

  const sports = [
    'Athletics', 'Football', 'Cricket', 'Badminton', 'Hockey', 'Basketball',
    'Swimming', 'Tennis', 'Volleyball', 'Wrestling', 'Boxing', 'Kabaddi'
  ];

  return names.map((name, index) => {
    const state = states[Math.floor(Math.random() * states.length)];
    const district = state.districts[Math.floor(Math.random() * state.districts.length)];
    const age = 14 + Math.floor(Math.random() * 6); // 14-19 years
    const gender: 'Male' | 'Female' = Math.random() > 0.5 ? 'Male' : 'Female';
    const numSports = 1 + Math.floor(Math.random() * 3); // 1-3 sports
    const selectedSports = sports.sort(() => 0.5 - Math.random()).slice(0, numSports);
    
    // Generate performance metrics
    const verticalJump = 40 + Math.floor(Math.random() * 30); // 40-70 cm
    const sitUps = 25 + Math.floor(Math.random() * 25); // 25-50 reps
    const shuttleRun = 8.5 + Math.random() * 4; // 8.5-12.5 seconds
    const flexibility = 10 + Math.floor(Math.random() * 15); // 10-25 cm
    const overallScore = Math.floor((verticalJump + sitUps + (15 - shuttleRun) * 4 + flexibility) / 4 * 1.5);
    
    const benchmarkStatus: 'Above' | 'At' | 'Below' = 
      overallScore >= 80 ? 'Above' : overallScore >= 70 ? 'At' : 'Below';
    
    const status: 'Active' | 'Pending' | 'Flagged' = 
      Math.random() > 0.9 ? 'Flagged' : Math.random() > 0.8 ? 'Pending' : 'Active';

    const registrationDate = new Date(2024, Math.floor(Math.random() * 3), Math.floor(Math.random() * 28) + 1);
    const lastAssessment = new Date(2024, 2 + Math.floor(Math.random() * 1), Math.floor(Math.random() * 28) + 1);

    return {
      id: `ATH${(index + 1).toString().padStart(3, '0')}`,
      name,
      age,
      gender,
      state: state.name,
      district,
      sportInterest: selectedSports,
      registrationDate: registrationDate.toISOString().split('T')[0],
      lastAssessment: lastAssessment.toISOString().split('T')[0],
      status,
      phoneNumber: `+91-98765432${(10 + index).toString().slice(-2)}`,
      performance: {
        verticalJump,
        sitUps,
        shuttleRun: Math.round(shuttleRun * 10) / 10,
        flexibility,
        overallScore: Math.min(100, overallScore)
      },
      benchmarkStatus,
      email: `${name.toLowerCase().replace(' ', '.')}@example.com`,
      address: `${Math.floor(Math.random() * 999) + 1}, Street ${Math.floor(Math.random() * 50) + 1}, ${district}, ${state.name}`,
      coachName: `Coach ${['Sharma', 'Singh', 'Kumar', 'Patel', 'Gupta'][Math.floor(Math.random() * 5)]}`,
      medicalClearance: Math.random() > 0.1 // 90% have medical clearance
    };
  });
};

const generateAssessments = (athletes: Omit<Athlete, 'createdAt' | 'updatedAt'>[]): Omit<Assessment, 'createdAt' | 'updatedAt'>[] => {
  const testTypes: Assessment['testType'][] = ['Vertical Jump', 'Sit-ups', 'Shuttle Run', 'Flexibility'];
  const assessments: Omit<Assessment, 'createdAt' | 'updatedAt'>[] = [];

  athletes.forEach(athlete => {
    // Generate 1-4 assessments per athlete
    const numAssessments = 1 + Math.floor(Math.random() * 4);
    
    for (let i = 0; i < numAssessments; i++) {
      const testType = testTypes[Math.floor(Math.random() * testTypes.length)];
      const submissionDate = new Date(2024, 2, Math.floor(Math.random() * 28) + 1);
      const aiScore = 60 + Math.floor(Math.random() * 40); // 60-100
      const cheatDetected = Math.random() > 0.95; // 5% cheat detection
      const status: Assessment['status'] = cheatDetected ? 'Flagged' : 
        Math.random() > 0.8 ? 'Pending' : 
        Math.random() > 0.95 ? 'Rejected' : 'Approved';

      let performanceMetric: number;
      switch (testType) {
        case 'Vertical Jump':
          performanceMetric = athlete.performance.verticalJump;
          break;
        case 'Sit-ups':
          performanceMetric = athlete.performance.sitUps;
          break;
        case 'Shuttle Run':
          performanceMetric = athlete.performance.shuttleRun;
          break;
        case 'Flexibility':
          performanceMetric = athlete.performance.flexibility;
          break;
      }

      const assessment: Omit<Assessment, 'createdAt' | 'updatedAt'> = {
        id: `ASS${assessments.length.toString().padStart(3, '0')}`,
        athleteId: athlete.id,
        athleteName: athlete.name,
        testType,
        submissionDate: submissionDate.toISOString(),
        status,
        aiScore,
        videoUrl: `https://example.com/videos/${athlete.id}_${testType.replace(/\s+/g, '_').toLowerCase()}.mp4`,
        cheatDetected,
        performanceMetric
      };
      
      // Only add optional fields if they have values
      if (status === 'Flagged') {
        assessment.reviewerNotes = 'Potential inconsistency detected';
      } else if (status === 'Rejected') {
        assessment.reviewerNotes = 'Invalid submission';
      } else if (Math.random() > 0.7) {
        assessment.reviewerNotes = 'Good performance';
      }
      
      if (status === 'Approved') {
        assessment.reviewerId = `REV${Math.floor(Math.random() * 5) + 1}`;
        assessment.reviewDate = new Date(submissionDate.getTime() + Math.random() * 86400000).toISOString();
      }
      
      assessments.push(assessment);
    }
  });

  return assessments;
};

const generateStateData = (): StateData[] => {
  return [
    {
      id: 'punjab',
      name: 'Punjab',
      athletes: 485,
      avgScore: 78.5,
      districts: ['Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala', 'Bathinda', 'Mohali', 'Hoshiarpur']
    },
    {
      id: 'haryana',
      name: 'Haryana',
      athletes: 423,
      avgScore: 76.2,
      districts: ['Gurugram', 'Faridabad', 'Panipat', 'Ambala', 'Karnal', 'Hisar', 'Sonipat']
    },
    {
      id: 'kerala',
      name: 'Kerala',
      athletes: 378,
      avgScore: 79.1,
      districts: ['Kochi', 'Thiruvananthapuram', 'Kozhikode', 'Thrissur', 'Kollam', 'Palakkad', 'Malappuram']
    },
    {
      id: 'rajasthan',
      name: 'Rajasthan',
      athletes: 342,
      avgScore: 74.8,
      districts: ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer', 'Bikaner', 'Alwar']
    },
    {
      id: 'tamil-nadu',
      name: 'Tamil Nadu',
      athletes: 389,
      avgScore: 77.3,
      districts: ['Chennai', 'Coimbatore', 'Madurai', 'Salem', 'Tiruchirappalli', 'Tirunelveli', 'Vellore']
    },
    {
      id: 'maharashtra',
      name: 'Maharashtra',
      athletes: 456,
      avgScore: 80.1,
      districts: ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Aurangabad', 'Solapur', 'Kolhapur']
    },
    {
      id: 'karnataka',
      name: 'Karnataka',
      athletes: 398,
      avgScore: 78.9,
      districts: ['Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum', 'Gulbarga', 'Shimoga']
    },
    {
      id: 'uttar-pradesh',
      name: 'Uttar Pradesh',
      athletes: 567,
      avgScore: 75.4,
      districts: ['Lucknow', 'Kanpur', 'Agra', 'Varanasi', 'Meerut', 'Allahabad', 'Bareilly']
    }
  ].map(state => ({
    ...state,
    createdAt: new Date('2024-01-01')
  }));
};

const generateSportsData = (): SportData[] => {
  return [
    {
      id: 'athletics',
      name: 'Athletics',
      category: 'Track and Field',
      description: 'Track and field events including running, jumping, and throwing',
      assessmentTypes: ['Vertical Jump', 'Shuttle Run', 'Flexibility'],
      benchmarks: {
        male: {
          'Vertical Jump': { excellent: 60, good: 50, average: 40 },
          'Shuttle Run': { excellent: 8.5, good: 9.5, average: 10.5 },
          'Flexibility': { excellent: 20, good: 15, average: 10 }
        },
        female: {
          'Vertical Jump': { excellent: 55, good: 45, average: 35 },
          'Shuttle Run': { excellent: 9.0, good: 10.0, average: 11.0 },
          'Flexibility': { excellent: 25, good: 20, average: 15 }
        }
      }
    },
    {
      id: 'football',
      name: 'Football',
      category: 'Team Sports',
      description: 'Association football requiring cardiovascular endurance and agility',
      assessmentTypes: ['Shuttle Run', 'Sit-ups', 'Flexibility'],
      benchmarks: {
        male: {
          'Shuttle Run': { excellent: 8.0, good: 9.0, average: 10.0 },
          'Sit-ups': { excellent: 50, good: 40, average: 30 },
          'Flexibility': { excellent: 18, good: 13, average: 8 }
        },
        female: {
          'Shuttle Run': { excellent: 8.5, good: 9.5, average: 10.5 },
          'Sit-ups': { excellent: 45, good: 35, average: 25 },
          'Flexibility': { excellent: 22, good: 17, average: 12 }
        }
      }
    },
    {
      id: 'cricket',
      name: 'Cricket',
      category: 'Bat and Ball Sports',
      description: 'Cricket requiring hand-eye coordination and fitness',
      assessmentTypes: ['Vertical Jump', 'Sit-ups', 'Shuttle Run'],
      benchmarks: {
        male: {
          'Vertical Jump': { excellent: 55, good: 45, average: 35 },
          'Sit-ups': { excellent: 45, good: 35, average: 25 },
          'Shuttle Run': { excellent: 9.0, good: 10.0, average: 11.0 }
        },
        female: {
          'Vertical Jump': { excellent: 50, good: 40, average: 30 },
          'Sit-ups': { excellent: 40, good: 30, average: 20 },
          'Shuttle Run': { excellent: 9.5, good: 10.5, average: 11.5 }
        }
      }
    },
    {
      id: 'badminton',
      name: 'Badminton',
      category: 'Racket Sports',
      description: 'Racket sport requiring agility and quick reflexes',
      assessmentTypes: ['Vertical Jump', 'Shuttle Run', 'Flexibility'],
      benchmarks: {
        male: {
          'Vertical Jump': { excellent: 65, good: 55, average: 45 },
          'Shuttle Run': { excellent: 8.0, good: 9.0, average: 10.0 },
          'Flexibility': { excellent: 20, good: 15, average: 10 }
        },
        female: {
          'Vertical Jump': { excellent: 60, good: 50, average: 40 },
          'Shuttle Run': { excellent: 8.5, good: 9.5, average: 10.5 },
          'Flexibility': { excellent: 25, good: 20, average: 15 }
        }
      }
    }
  ].map(sport => ({
    ...sport,
    createdAt: new Date('2024-01-01')
  }));
};

// Main seeding function
export async function seedFirestore() {
  if (!db) {
    throw new Error('Firebase is not initialized. Please check your environment variables.');
  }

  console.log('Starting Firestore seeding...');

  try {
    // Generate sample data
    const athletes = generateAthletes();
    const assessments = generateAssessments(athletes);
    const stateData = generateStateData();
    const sportsData = generateSportsData();

    // Dashboard metrics
    const dashboardMetrics: DashboardMetrics = {
      totalAthletes: athletes.length,
      pendingAssessments: assessments.filter(a => a.status === 'Pending').length,
      verifiedAssessments: assessments.filter(a => a.status === 'Approved').length,
      flaggedAssessments: assessments.filter(a => a.status === 'Flagged').length,
      monthlyGrowth: '+12.5%',
      approvalRate: '94.2%',
      avgProcessingTime: '2.3 hrs',
      topPerformingState: 'Maharashtra',
      lastUpdated: new Date()
    };

    // Create a batch for better performance
    const batch = writeBatch(db);

    // Seed athletes
    console.log('Seeding athletes...');
    for (const athlete of athletes) {
      const athleteDoc = doc(db, 'athletes', athlete.id);
      batch.set(athleteDoc, {
        ...athlete,
        createdAt: new Date(),
        updatedAt: new Date()
      });
    }

    // Seed assessments
    console.log('Seeding assessments...');
    for (const assessment of assessments) {
      const assessmentDoc = doc(db, 'assessments', assessment.id);
      batch.set(assessmentDoc, {
        ...assessment,
        createdAt: new Date(),
        updatedAt: new Date()
      });
    }

    // Seed states
    console.log('Seeding states...');
    for (const state of stateData) {
      const stateDoc = doc(db, 'states', state.id);
      batch.set(stateDoc, state);
    }

    // Seed sports
    console.log('Seeding sports...');
    for (const sport of sportsData) {
      const sportDoc = doc(db, 'sports', sport.id);
      batch.set(sportDoc, sport);
    }

    // Seed dashboard metrics
    console.log('Seeding dashboard metrics...');
    const metricsDoc = doc(db, 'analytics', 'dashboard-metrics');
    batch.set(metricsDoc, dashboardMetrics);

    // Commit the batch
    await batch.commit();

    console.log('Firestore seeding completed successfully!');
    console.log(`Seeded ${athletes.length} athletes, ${assessments.length} assessments, ${stateData.length} states, and ${sportsData.length} sports.`);

    return {
      success: true,
      counts: {
        athletes: athletes.length,
        assessments: assessments.length,
        states: stateData.length,
        sports: sportsData.length
      }
    };

  } catch (error) {
    console.error('Error seeding Firestore:', error);
    throw error;
  }
}

// Function to clear all data (use with caution)
export async function clearFirestore() {
  if (!db) {
    throw new Error('Firebase is not initialized.');
  }

  console.log('Clearing Firestore data...');
  
  const collections = ['athletes', 'assessments', 'states', 'sports', 'analytics'];
  
  for (const collectionName of collections) {
    const snapshot = await getDocs(collection(db, collectionName));
    const batch = writeBatch(db);
    
    snapshot.docs.forEach(docSnap => {
      batch.delete(docSnap.ref);
    });
    
    await batch.commit();
    console.log(`Cleared ${collectionName} collection`);
  }
  
  console.log('Firestore clearing completed!');
}
