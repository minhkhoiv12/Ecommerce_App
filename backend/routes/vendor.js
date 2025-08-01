const express = require('express');
const Vendor = require('../models/vendor');
const vendorRouter = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
vendorRouter.post('/api/vendor/signup', async (req, res) => {
    try{
        const {fullName, email, password}= req.body;
        const existingEmail = await Vendor.findOne({ email});
        if(existingEmail)
        {
            return res.status(400).json({msg: 'Email đã tồn tại'});
        }
        else{
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);
            let vendor = new Vendor({
                fullName,
                email,
                password: hashedPassword
            });
            vendor = await Vendor.save();
            return res.json({vendor});
        }
    }
    catch(e)
    {
        return res.status(500).json({msg: 'Internal server error', error: e.message});

    }
});
vendorRouter.post('/api/vendor/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const findVendor = await Vendor.findOne({email});
        if(!findVendor) {
            return res.status(400).json({msg: 'Invalid email'});
        }
        else {
            const isMatch = await bcrypt.compare(password, findVendor.password);
            if(!isMatch) {
                return res.status(400).json({msg: 'Invalid password'});
            }
            else {
                const token = jwt.sign({id: findVendor._id}, process.env.SECRET);
                // remove sensitive information - like the password
                const { password, ...vendorWithoutPassword } = findVendor._doc;
                // send teh response
                return res.json({
                    token, vendor:vendorWithoutPassword
                });
            }
        }


    }
    catch(e){
        return res.status(500).json({error: e.message});

    }
});
module.exports = vendorRouter;
