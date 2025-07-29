const express = require("express");
const Category = require('../models/category');
const categoryRouter = express.Router();
categoryRouter.post('/api/categories', async(req, res) => {
    try{
        const {name, image, banner} = req.body;
        let category = new Category({name, image, banner});
         category = await category.save();
         return res.status(201).json({category});
    }
    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
categoryRouter.get('/api/categories', async(req, res) => {
    try{
        const categories = await Category.find();
         return res.status(200).json(categories);
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});
module.exports = categoryRouter;
