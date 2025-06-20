import 'package:dashboard_ecomerce/views/side_bar_screen/buyer_screen.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/category_screen.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/order_screen.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/product_screen.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/upload_banner_screen.dart';
import 'package:dashboard_ecomerce/views/side_bar_screen/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorScreen();
  screenSelector(item) {
    switch (item.route) {
      case BuyerScreen.id:
        setState(() {
          _selectedScreen = BuyerScreen();
        });
        break;

      case VendorScreen.id:
        setState(() {
          _selectedScreen = VendorScreen();
        });
        break;
      
      case OrderScreen.id:
        setState(() {
          _selectedScreen = OrderScreen();
        });
        break;

      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;

      case UploadBanner.id:
        setState(() {
          _selectedScreen = UploadBanner();
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Management"),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        items: const [
          AdminMenuItem(title: 'Vendors', route: VendorScreen.id, icon: CupertinoIcons.person_3,),
          AdminMenuItem(title: 'Buyer', route: BuyerScreen.id , icon: CupertinoIcons.person,),
          AdminMenuItem(title: 'Orders', route: OrderScreen.id, icon: CupertinoIcons.shopping_cart,),
          AdminMenuItem(title: 'Categories', route: CategoryScreen.id, icon: Icons.category,),
          AdminMenuItem(title: 'Upload Banner', route: UploadBanner.id, icon: Icons.upload,),
           AdminMenuItem(title: 'Products', route: ProductScreen.id, icon: Icons.store,),
        ],
        selectedRoute: VendorScreen.id,
        onSelected: (item) {
          screenSelector(item);
        } ,
      ),
    );
  }
}
