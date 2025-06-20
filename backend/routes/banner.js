const express = require("express");
const Banner = require('../models/banner');
const bannerRouter = express.Router();

bannerRouter.post('/api/banner', async(req, res) => {
    try{
        const {image} = req.body;
        let banner = new Banner({image});
         banner = await banner.save();
         return res.status(201).json({banner});
    }

    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
bannerRouter.get('/api/banner', async(req, res) => {
    try{
        const banners = await Banner.find();
         return res.status(201).json({banners});
    }

    catch(e) {
        return res.status(500).json({error: e.message});

    }
});
module.exports = bannerRouter;
