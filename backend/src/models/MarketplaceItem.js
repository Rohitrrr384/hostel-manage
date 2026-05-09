import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const marketplaceItemSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    sellerId: { type: String, required: true, index: true },
    sellerName: { type: String, required: true },
    roomNumber: { type: String, required: true },
    title: { type: String, required: true },
    description: { type: String, required: true },
    price: { type: Number, required: true, min: 0 },
    category: { type: String, enum: ['books', 'electronics', 'clothes', 'furniture', 'food', 'other'], default: 'other' },
    images: [{ type: String }],
    isAvailable: { type: Boolean, default: true },
  },
  { timestamps: true, id: false },
);

export const MarketplaceItem = mongoose.model('MarketplaceItem', marketplaceItemSchema);
