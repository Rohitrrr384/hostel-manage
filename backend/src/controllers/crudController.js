import { ApiError } from '../utils/apiError.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export function list(Model, buildQuery = () => ({})) {
  return asyncHandler(async (req, res) => {
    const items = await Model.find(buildQuery(req)).sort({ createdAt: -1 });
    res.json({ success: true, count: items.length, data: items });
  });
}

export function getOne(Model) {
  return asyncHandler(async (req, res) => {
    const item = await Model.findOne({ id: req.params.id });
    if (!item) throw new ApiError(404, 'Resource not found');
    res.json({ success: true, data: item });
  });
}

export function createOne(Model, mapBody = (req) => req.body) {
  return asyncHandler(async (req, res) => {
    const item = await Model.create(mapBody(req));
    res.status(201).json({ success: true, data: item });
  });
}

export function updateOne(Model, mapBody = (req) => req.body) {
  return asyncHandler(async (req, res) => {
    const item = await Model.findOneAndUpdate(
      { id: req.params.id },
      mapBody(req),
      { new: true, runValidators: true },
    );
    if (!item) throw new ApiError(404, 'Resource not found');
    res.json({ success: true, data: item });
  });
}

export function deleteOne(Model) {
  return asyncHandler(async (req, res) => {
    const item = await Model.findOneAndDelete({ id: req.params.id });
    if (!item) throw new ApiError(404, 'Resource not found');
    res.json({ success: true, message: 'Deleted successfully' });
  });
}
