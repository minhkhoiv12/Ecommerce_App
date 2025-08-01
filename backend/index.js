const express = require('express');
const cors = require('cors');
const app = express();
const dotenv = require("dotenv");
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const bannerRouter =require('./routes/banner');
const categoryRouter = require('./routes/category');
const subCategoryRouter = require('./routes/sub_category');
const productRouter = require('./routes/product');
const productReviewRouter = require('./routes/product_review');
const vendorRouter = require('./routes/vendor'); 
const PORT = process.env.PORT || 3000;
dotenv.config({
  path: "config/config.env",
});
app.use(cors()); // 
app.use(express.json());
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subCategoryRouter);
app.use(productRouter);
app.use(productReviewRouter);
app.use(vendorRouter);
mongoose.connect(process.env.DB, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => {
  console.log('Connected to MongoDB');
}).catch(err => {
  console.error('Error connecting to MongoDB:', err);
});
app.listen(PORT,() => {
  console.log(`Server is running on http://localhost:${PORT}`);
});