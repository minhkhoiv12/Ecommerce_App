const express = require('express');
const orderRouter = express.Router();
const Order = require('../models/order');

//Post router for creating orders
orderRouter.post('/api/orders', async(req, res)=>{
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
            createdAt
        });
        await order.save();
        return res.status(201).json(order);

    }catch(e){
        res.status(500).json({error: e.message});
    }
});
//GET route for fetching orders by buyer ID
orderRouter.get('/api/orders/:buyerId', async(req, res)=>{
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
orderRouter.delete("/api/orders/:id", async (req, res)=> {
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

//GET route for fetching orders by vendor ID
orderRouter.get('/api/orders/vendors/:vendorId', async(req, res)=>{
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
module.exports = orderRouter;