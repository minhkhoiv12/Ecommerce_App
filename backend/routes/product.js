const express = require("express");
const Product = require('../models/product');
const productRouter = express.Router();
const {auth, vendorAuth} = require('../middleware/auth')
productRouter.post('/api/add-product',auth, vendorAuth, async(req, res) => {
    try{
        const {productName, productPrice, quantity, description, category, vendorId, fullName, subCategory, images} = req.body;
        let product = new Product({productName, productPrice, quantity, description, category, vendorId, fullName, subCategory, images});
         product = await product.save();
         return res.status(201).send(product);
    }
    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
productRouter.get('/api/popular-products',async(req, res) => {
    try{
        const product = await Product.find({popular: true});
        if(!product || product.length ==0){
            return res.status(404).json({msg: "Không tìm thấy sản phẩm"});
        }
        else{
            return res.status(200).json(product);
        }
    }
    catch(e) {
        return res.status(500).json({error: e.message});

    }
});

productRouter.get('/api/recommended-products', async(req, res) => {
    try{
        const product = await Product.find({recommend: true});
        if(!product || product.length ==0){
            return res.status(404).json({msg: "Không tìm thấy sản phẩm"});
        }
        else{
            return res.status(201).json({product});
        }
    }
    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
// new route for retrieving products by category
productRouter.get('/api/products-by-category/:category',async(req, res) => {
    try {
        const {category} = req.params;
        const products = await Product.find({category,popular: true});
        if(!products || products.length == 0) {
            return res.status(404).json({msg: "Không tìm thấy sản phẩm trong danh mục này"});
        }
        else {
            return res.status(200).json(products);
        }
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});
//new route for retrieving related products by subcategory
productRouter.get('/api/related-products-by-subcategory/:productId', async(req,res)=>{
    try{
        const {productId} = req.params;
        //first, find product to get its subcategory
        const product =  await Product.findById(productId);
        if(!product){
            return res.status(404).json({msg: "Không tìm thấy sản phẩm"});

        }
        else {
            //find related products base on the subcategory of the retrieved product
            const relatedProducts = await Product.find({
                subCategory: product.subCategory,
                _id:{$ne: productId}// Exclude the current product
            });
            if(!relatedProducts || relatedProducts.length ==0){
                return res.status(404).json({msg: "Không tìm thấy sản phẩm liên quan"});
            }
            return res.status(200).json(relatedProducts);
        }

    }
    catch (e){
        return res.status(500).json({error: e.message});
    }
});
//route for retrieving the top 10 highest-rated products
productRouter.get('/api/top-rated-products', async(req,res)=>{
    try{
        //fetch all products and sort them by avaragerating in decending order(higest rating)
        //sort product by averageRating with -1 indicating decending
        const topRatedProducts = await Product.find({}).sort({averageRating: -1}).limit(10);
        //check if there are any top-rated products returned
        if(!topRatedProducts || topRatedProducts.length==0){
            return res.status(404).json({msg: "Không tìm thấy sản phẩm được đánh giá cao nào"});
        }
        //return the top-rated product as a response
        return res.status(200).json(topRatedProducts);
    }
    catch(e){
        //handle any server errors that occure during the request
        return res.status(500).json({error: e.message});
    }
});
productRouter.get('/api/products-by-subcategory/:subCategory', async (req, res) => {
    try {
        const {subCategory} = req.params;
        const products = await Product.find({subCategory:subCategory});
        if(!products || !products.length ==0){
            return res.status(404).json({msg: "Không tìm thấy danh mục con này"});
        }
        return res.status(200).json(products);
        
    }
    catch (e){
        res.status(500).json({error: e.message});
    }
});
//Route for searching products by name or description
productRouter.get('/api/search-products', async(req,res)=> {
    try {
        //Extract the query parameter from the request query string
        const {query} = req.query;
        //Validate that a query parameter is provided
        //if missing , return a 400 status with an error message 
        if(!query){
            return res.status(400).json({msg: "Query parameter required"});
        }
        //search for the Product collection for documents where either productName or "description"
        //contains the specified query String;
       const products =  await Product.find({
            $or: [
                //Regex will match any productName containing the query String,
                //For example, if the user search for "apple", the regex will check
                //if "apple" is part of any productName, so product name "Green Apple pie",
                //or "Fresh Apples", would all match because they contain the world "apple"

                {productName: {$regex:query, $options:"i"}}, 
                {description: {$regex:query, $options:"i"}}, 


            ]
        });
        //check if any products were found, if no product match the query 
        // return a 404 status code with a message
        if(!products || products.length ==0){
            return res.status(404).json({msg: "Không có sản phẩm nào được tìm thấy"});
        }
        //if product are found, return 200
        return res.status(200).json(products);
    }
    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
module.exports = productRouter;
