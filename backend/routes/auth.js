const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');

authRouter.post('/api/signup', async (req, res) => {
    try{
        const {fullName, email, password}= req.body;
        const existingEmail = await User.findOne({ email});
        if(existingEmail)
        {
            return res.status(400).json({msg: 'Email already exists'});
        }
        else{
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);
            let user = new User({
                fullName,
                email,
                password: hashedPassword
            });
            user = await user.save();
            return res.json({user});
        }
    }
    catch(e)
    {
        return res.status(500).json({msg: 'Internal server error', error: e.message});

    }
});
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const findUser = await User.findOne({email});
        if(!findUser) {
            return res.status(400).json({msg: 'Invalid email'});
        }
        else {
            const isMatch = await bcrypt.compare(password, findUser.password);
            if(!isMatch) {
                return res.status(400).json({msg: 'Invalid password'});
            }
            else {
                const token = jwt.sign({id: findUser._id}, process.env.SECRET);
                // remove sensitive information
                const { password, ...userWithoutPassword } = findUser._doc;
                // send teh response
                return res.json({
                    token, ...userWithoutPassword
                });
            }
        }


    }
    catch(e){
        return res.status(500).json({error: e.message});

    }
});
module.exports = authRouter;
