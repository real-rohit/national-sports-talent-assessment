import { seedFirestore } from './lib/seedFirestore';

// Simple script to run the seeding
async function runSeeding() {
  try {
    console.log('🌱 Starting database seeding...');
    const result = await seedFirestore();
    
    if (result.success) {
      console.log('✅ Database seeding completed successfully!');
      console.log('📊 Summary:', result.counts);
    }
  } catch (error) {
    console.error('❌ Error during seeding:', error);
  }
}

// Run if this script is executed directly
if (typeof window === 'undefined') {
  runSeeding();
}

export { runSeeding };
