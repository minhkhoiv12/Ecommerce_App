import 'package:bai1/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderProvider extends StateNotifier<List<Order> >{
  OrderProvider(): super([]);
  //set the list of Orders
  void setOrders(List<Order> orders){
    state = orders;
  }
  // remove order by id
  void removeOrder(String orderId) {
    state = state.where((order) => order.id != orderId).toList();
  }
} 
final orderProvider = StateNotifierProvider<OrderProvider, List<Order>>((ref) => OrderProvider());