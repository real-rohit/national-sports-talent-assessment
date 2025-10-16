// Mock data for the SAI Sports Assessment Admin Panel

export interface Athlete {
  id: string
  name: string
  age: number
  gender: 'Male' | 'Female'
  state: string
  district: string
  sportInterest: string[]
  registrationDate: string
  lastAssessment: string
  status: 'Active' | 'Pending' | 'Flagged'
  phoneNumber: string
  performance: {
    verticalJump: number // cm
    sitUps: number // reps in 1 min
    shuttleRun: number // seconds
    flexibility: number // cm
    overallScore: number // percentage
  }
  benchmarkStatus: 'Above' | 'At' | 'Below'
}

export interface Assessment {
  id: string
  athleteId: string
  athleteName: string
  testType: 'Vertical Jump' | 'Sit-ups' | 'Shuttle Run' | 'Flexibility'
  submissionDate: string
  status: 'Approved' | 'Pending' | 'Flagged' | 'Rejected'
  aiScore: number
  reviewerNotes?: string
  videoUrl?: string
  cheatDetected: boolean
  performanceMetric: number
}

export const mockAthletes: Athlete[] = [
  {
    id: 'ATH001',
    name: 'Arjun Kumar',
    age: 17,
    gender: 'Male',
    state: 'Punjab',
    district: 'Ludhiana',
    sportInterest: ['Athletics', 'Football'],
    registrationDate: '2024-01-15',
    lastAssessment: '2024-03-10',
    status: 'Active',
    phoneNumber: '+91-9876543210',
    performance: {
      verticalJump: 58,
      sitUps: 42,
      shuttleRun: 9.2,
      flexibility: 15,
      overallScore: 85
    },
    benchmarkStatus: 'Above'
  },
  {
    id: 'ATH002',
    name: 'Priya Sharma',
    age: 16,
    gender: 'Female',
    state: 'Haryana',
    district: 'Gurugram',
    sportInterest: ['Badminton', 'Athletics'],
    registrationDate: '2024-02-03',
    lastAssessment: '2024-03-12',
    status: 'Active',
    phoneNumber: '+91-9876543211',
    performance: {
      verticalJump: 52,
      sitUps: 38,
      shuttleRun: 10.1,
      flexibility: 18,
      overallScore: 78
    },
    benchmarkStatus: 'At'
  },
  {
    id: 'ATH003',
    name: 'Rohit Singh',
    age: 18,
    gender: 'Male',
    state: 'Rajasthan',
    district: 'Jaipur',
    sportInterest: ['Cricket', 'Hockey'],
    registrationDate: '2024-01-28',
    lastAssessment: '2024-03-08',
    status: 'Flagged',
    phoneNumber: '+91-9876543212',
    performance: {
      verticalJump: 45,
      sitUps: 35,
      shuttleRun: 11.5,
      flexibility: 12,
      overallScore: 62
    },
    benchmarkStatus: 'Below'
  },
  {
    id: 'ATH004',
    name: 'Anjali Devi',
    age: 17,
    gender: 'Female',
    state: 'Kerala',
    district: 'Kochi',
    sportInterest: ['Swimming', 'Athletics'],
    registrationDate: '2024-02-15',
    lastAssessment: '2024-03-11',
    status: 'Active',
    phoneNumber: '+91-9876543213',
    performance: {
      verticalJump: 55,
      sitUps: 40,
      shuttleRun: 9.8,
      flexibility: 16,
      overallScore: 82
    },
    benchmarkStatus: 'Above'
  }
]

export const mockAssessments: Assessment[] = [
  {
    id: 'ASS001',
    athleteId: 'ATH001',
    athleteName: 'Arjun Kumar',
    testType: 'Vertical Jump',
    submissionDate: '2024-03-10T10:30:00Z',
    status: 'Approved',
    aiScore: 95,
    reviewerNotes: 'Excellent form and technique',
    cheatDetected: false,
    performanceMetric: 58
  },
  {
    id: 'ASS002',
    athleteId: 'ATH002',
    athleteName: 'Priya Sharma',
    testType: 'Sit-ups',
    submissionDate: '2024-03-12T14:15:00Z',
    status: 'Pending',
    aiScore: 88,
    cheatDetected: false,
    performanceMetric: 38
  },
  {
    id: 'ASS003',
    athleteId: 'ATH003',
    athleteName: 'Rohit Singh',
    testType: 'Shuttle Run',
    submissionDate: '2024-03-08T09:45:00Z',
    status: 'Flagged',
    aiScore: 45,
    reviewerNotes: 'Potential timing inconsistency detected',
    cheatDetected: true,
    performanceMetric: 11.5
  }
]

export const dashboardMetrics = {
  totalAthletes: 2847,
  pendingAssessments: 127,
  verifiedAssessments: 1923,
  flaggedAssessments: 23,
  monthlyGrowth: '+12.5%',
  approvalRate: '94.2%',
  avgProcessingTime: '2.3 hrs',
  topPerformingState: 'Punjab'
}

export const performanceDistribution = {
  byState: [
    { state: 'Punjab', athletes: 485, avgScore: 78.5 },
    { state: 'Haryana', athletes: 423, avgScore: 76.2 },
    { state: 'Kerala', athletes: 378, avgScore: 79.1 },
    { state: 'Rajasthan', athletes: 342, avgScore: 74.8 },
    { state: 'Tamil Nadu', athletes: 389, avgScore: 77.3 }
  ],
  byGender: [
    { gender: 'Male', count: 1547, percentage: 54.3 },
    { gender: 'Female', count: 1300, percentage: 45.7 }
  ],
  byAge: [
    { ageGroup: '14-15', count: 654, percentage: 23 },
    { ageGroup: '16-17', count: 1285, percentage: 45.1 },
    { ageGroup: '18-19', count: 908, percentage: 31.9 }
  ]
}