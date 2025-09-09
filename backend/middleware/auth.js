const jwt = require('jsonwebtoken');
const User = require('../models/user');
const Vendor = require('../models/vendor')
//authentication middleware
//this middleware function checks if the user is authenticated
const auth = async(req, res, next) =>{
    try {
        //extract the token from the request headers
        const token = req.header('x-auth-token');
        //if no token is provided, return 401(unauthorized) response with an error message
        if(!token){
            return res.status(401).json({msg: "Thiếu mã xác thực, vui lòng đăng nhập để tiếp tục"});
        }
        //verify the jwt token using the secret key
        const verified = jwt.verify(token, "passwordKey");
        // if the token verification failed, return 401,
        if(!verified){
            return res.status(401).json({msg:"Mã xác thực không hợp lệ hoặc đã hết hạn, vui lòng đăng nhập lại"})
        }
        //find the normal user or vendor in the database using the id stored in the token payload
        const user = await User.findById(verified.id) || await Vendor.findById(verified.id);
        if(!user){
            return res.status(401).json({msg: "Không tìm thấy tài khoản hợp lệ, quyền truy cập bị từ chối"});
        }
        //attact the authenticated user (whether a normal user or a vendor) to the request objects
        //this makes the user's data available to any subsequence middleware or route handlers
        req.user = user;
        //also attact the token to the request object in case is needed later
        req.token = token;
        //proceed to the next middleware or route handler
        next();

    } catch (e) {
        res.status(500).json({error: e.message});
    }
};
//vendor authentication middleware
//this middleware ensures that the user making the request is a vendor
//it should be used for routes that only vendor can access
const vendorAuth = (req,res,next)=>{
    try{
        //check if the user making the request is a vendor (by checking the "role" property)
        if(!req.user.role || req.user.role !=='vendor'){
            //if the user is not a vendor, return 403(Forbidden) response with an error message
            return res.status(403).json({msg:"Quyền truy cập bị từ chối, chỉ có người bán hàng được phép truy cập trang này"});
        }
        //if the user is a vendor, procceed to the next middleware or route handler
        next();

    }
    catch(e){
        return res.status(500).json({error: e.message});
    }
};
module.exports = {auth, vendorAuth};