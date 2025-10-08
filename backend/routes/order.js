const express = require('express');
const orderRouter = express.Router();
const Order = require('../models/order');
const stripe = require('stripe')(process.env.STRIPE);
const {auth, vendorAuth} = require('../middleware/auth');
//Post router for creating orders
orderRouter.post('/api/orders',auth,async(req, res)=>{
    try {

        const {
            fullName, 
            email, 
            state, 
            city, 
            locality, 
            productName, 
            productPrice, 
            quantity,
            category,
            image,
            vendorId,
            buyerId,
            paymentStatus,
            paymentIntentId,
            paymentMethod,
            
        } = req.body;
        const createdAt = new Date().getMilliseconds();//Get the current date
        //create new order instance with the extracted field
        const order = new Order({fullName, 
            email, 
            state, 
            city, 
            locality, 
            productName, 
            productPrice, 
            quantity,
            category,
            image,
            vendorId,
            buyerId,
            createdAt,
            paymentStatus,
            paymentIntentId,
            paymentMethod,
        });
        await order.save();
        return res.status(201).json(order);

    }catch(e){
        res.status(500).json({error: e.message});
    }
});
//GET route for fetching orders by buyer ID
orderRouter.get('/api/orders/:buyerId',auth, async(req, res)=>{
    try {
        //Extract buyerId from the request parameters
        const {buyerId} = req.params;
        //Find all orders in the database that match the buyerid
        const orders = await Order.find({buyerId});
        //if no orders are found, return a 404 status with a message
        if(orders.length === 0){
            return res.status(404).json({msg: "không tìm thấy đơn hàng nào cho người mua này"});
        }
        //if orders are found, return them with a 200 status code
        return res.status(200).json(orders);
    }
    catch(e){
        //Handle any errors that occure during the order retrieval process
        res.status(500).json({error: e.message});
    }
});

// Delete route for deleting specific order by _id
orderRouter.delete("/api/orders/:id",auth, async (req, res)=> {
    try {
        //extract the id from the request parameter
        const {id} = req.params;
        //find and delete order from the data base using the extracted _id
        const deletedOrder = await Order.findByIdAndDelete(id);
        //check if an order was found and deleted
        if(!deletedOrder){
            //if no order was found with the provided _id return 404
            return res.status(404).json({msg: "không tìm thấy đơn hàng với id đã cho"});
        }
        else {
            //if the order was successfully deleted, return 200 status with a success massage
            return res.status(200).json({msg: "đơn hàng đã được xóa thành công"});
        }
    }
    catch(e){
        //if an error occures during the process, return a 500 status with error message
        res.status(500).json({error: e.message});
    }   
});

orderRouter.post('/api/payment', async (req, res)=> {
    try {
        const {orderId, paymentMethodId, currency='usd'} = req.body;
        //validate the presence of the required fields
        if(!orderId || !paymentMethodId || !currency){
            return res.status(400).json({msg: "Thiếu trường yêu cầu"});
        }
        //Query for the order by orderId
        const order = await Order.findById(orderId);
        if(!order){
            console.log("Không tìm thấy đơn hàng", orderId);
            return res.status(404).json({msg: "Không tìm thấy đơn hàng"});
        }
        //calculate the total amount(price * quantity)
        const totalAmount = order.productPrice * order.quantity;
        //Ensure the amount is at least $0.50 USD or its equivalent
        const miniumAmount = 0.50;
        if(totalAmount < miniumAmount){
            return res.status(400).json({error: "hệ thống không chấp nhận giao dịch nhỏ hơn 0.50 USD."});
        }
        //convert total amount to cents(Stripe requires the amount in cents)
        const amountInCents = Math.round(totalAmount * 100);
        //Now create the Payment intent with the correct amount
        const paymentIntent = await stripe.paymentIntents.create({
            amount: amountInCents,
            currency: currency,
            payment_method: paymentMethodId,
            automatic_payment_methods: {enabled: true},
        });
        return res.json({
            status: "Thành công",
            paymentIntentId: paymentIntent.id,
            amount: paymentIntent.amount /100,
            currency: paymentIntent.currency,
        });
    }
    catch (e){
        res.status(500).json({error: e.message});

    }
});
orderRouter.post('/api/payment-intent',auth, async (req, res)=> {
    try {
        const {amount, currency} = req.body;
        const paymentIntent = await stripe.paymentIntents.create({
            amount,
            currency,
        });
        return res.status(200).json(paymentIntent);

    }
    catch (e){
        return res.status(500).json({error: e.message});

    }
});
orderRouter.get('/api/payment-intent/:id', auth, async (req,res)=> {
    try {
        const paymentIntent = await stripe.paymentIntents.retrieve(req.params.id);
        return res.status(200).json(paymentIntent);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }
});

//GET route for fetching orders by vendor ID
orderRouter.get('/api/orders/vendors/:vendorId',auth,vendorAuth, async(req, res)=>{
    try {
        //Extract vendorId from the request parameters
        const {vendorId} = req.params;
        //Find all orders in the database that match the vendorid
        const orders = await Order.find({vendorId});
        //if no orders are found, return a 404 status with a message
        if(orders.length === 0){
            return res.status(404).json({msg: "không tìm thấy đơn hàng nào cho người bán này"});
        }
        //if orders are found, return them with a 200 status code
        return res.status(200).json(orders);
    }
    catch(e){
        //Handle any errors that occure during the order retrieval process
        res.status(500).json({error: e.message});
    }
});
orderRouter.patch('/api/orders/:id/delivered', async (req, res) => {
    try {
        const {id} = req.params;
        const updatedOrder = await Order.findByIdAndUpdate(id, {delivered: true, processing: false}, {new: true});
        if(!updatedOrder) {
            return res.status(404).json({msg: "không tìm thấy đơn hàng với id đã cho"});
        }
        else {
            return res.status(200).json(updatedOrder);
        }
    }
    catch (e) {
        res.status(500).json({error: e.message});

    }

});
orderRouter.patch('/api/orders/:id/processing', async (req, res) => {
    try {
        const {id} = req.params;
        const updatedOrder = await Order.findByIdAndUpdate(id, {processing: false, delivered: false}, {new: true});
        if(!updatedOrder) {
            return res.status(404).json({msg: "không tìm thấy đơn hàng với id đã cho"});
        }
        else {
            return res.status(200).json(updatedOrder);
        }
    }
    catch (e) {
        res.status(500).json({error: e.message});

    }

});
orderRouter.get('/api/orders', async(req, res)=>{
    try {
        const orders = await Order.find();
        return res.status(200).json(orders);
    } catch (e) {
         res.status(500).json({error: e.message});
    }
});
module.exports = orderRouter;