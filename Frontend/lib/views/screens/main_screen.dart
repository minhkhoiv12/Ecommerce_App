import 'package:bai1/views/screens/nav_screens/account_screen.dart';
import 'package:bai1/views/screens/nav_screens/cart_screen.dart';
import 'package:bai1/views/screens/nav_screens/favorite_screen.dart';
import 'package:bai1/views/screens/nav_screens/home_screen.dart';
import 'package:bai1/views/screens/nav_screens/stores_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex =0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    StoresScreen(),
    CartScreen(),
    AccountScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.green,

        currentIndex: _pageIndex,// xac dinh tab dang duoc chon
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(icon: Image.asset('assets/icons/home.png', width: 25,), label: 'Home'),
        BottomNavigationBarItem(icon: Image.asset('assets/icons/love.png', width: 25,), label: 'Favorite'),
        BottomNavigationBarItem(icon: Image.asset('assets/icons/mart.png', width: 25,), label: 'Stores'),
        BottomNavigationBarItem(icon: Image.asset('assets/icons/cart.png', width: 25,), label: 'Cart'),
        BottomNavigationBarItem(icon: Image.asset('assets/icons/user.png', width: 25,), label: 'Account'),
      ]),
      body: _pages[_pageIndex],

    );
  }
}