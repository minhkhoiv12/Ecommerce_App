const express = require("express");
const Product = require('../models/product');
const productRouter = express.Router();

productRouter.post('/api/add-product', async(req, res) => {
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
productRouter.get('/api/popular-products', async(req, res) => {
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
productRouter.get('/api/products-by-category/:category', async(req, res) => {
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
    catch(error) {
        return res.status(500).json({error: e.message});
    }
})
module.exports = productRouter;
