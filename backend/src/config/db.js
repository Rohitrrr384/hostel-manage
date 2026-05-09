import mongoose from 'mongoose';

export async function connectDb() {
  const uri = process.env.MONGO_URI;
  if (!uri) {
    throw new Error('MONGO_URI is missing. Copy .env.example to .env and set MongoDB connection string.');
  }

  mongoose.set('strictQuery', true);
  try {
    await mongoose.connect(uri);
    console.log(`MongoDB connected: ${mongoose.connection.name}`);
  } catch (error) {
    if (error?.message?.includes('ECONNREFUSED')) {
      throw new Error(
        `MongoDB is not running at ${uri}. Start it with: npm run mongo:init && npm run mongo`,
      );
    }
    throw error;
  }
}
