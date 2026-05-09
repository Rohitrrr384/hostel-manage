import fs from 'fs';
import path from 'path';

const dir = path.resolve('data/db');
fs.mkdirSync(dir, { recursive: true });
console.log(`MongoDB data directory ready: ${dir}`);
