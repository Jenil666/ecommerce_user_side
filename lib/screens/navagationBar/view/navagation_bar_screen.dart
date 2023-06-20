import 'package:ecommerce_user_side/screens/ReadData/controller/ReadDataController.dart';
import 'package:ecommerce_user_side/screens/ReadData/view/read_data_screen.dart';
import 'package:ecommerce_user_side/screens/cart/view/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Dispatched/view/dispatched_screen.dart';
import '../../buy/view/buy_product_screen.dart';
import '../../cart/controller/cart_screen_controller.dart';

class BottomNavagationScreen extends StatelessWidget {
  const BottomNavagationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReadDataController getx = Get.put(ReadDataController());
    CartScreenController getxCartScreenController = Get.put(CartScreenController());
    return  PersistentTabView(
      // onItemSelected: (value) {
      //   getxCartScreenController.getIdOfProducts();
      //   CartScreen();
      // },
        context,
        screens: [
          ReadDataScreen(),
          CartScreen(),
          BuyProductScreen(),
          DispatchedScreen(),
        ],
        items: [
          PersistentBottomNavBarItem(icon: Icon(Icons.home_filled,),title: 'Home',activeColorPrimary: Colors.orange,inactiveColorPrimary: Color(0xffCFCFCF)),
          PersistentBottomNavBarItem(icon: Icon(Icons.shopping_bag_outlined),title: 'Cart',activeColorPrimary: Colors.orange,inactiveColorPrimary: Color(0xffCFCFCF),),
          PersistentBottomNavBarItem(icon: Icon(Icons.offline_pin_rounded),title: 'Ordered',activeColorPrimary: Colors.orange,inactiveColorPrimary: Color(0xffCFCFCF)),
          PersistentBottomNavBarItem(icon: Icon(Icons.move_down),title: 'Dispatched',activeColorPrimary: Colors.orange,inactiveColorPrimary: Color(0xffCFCFCF)),
        ],
        controller: getx.preController,
        navBarStyle: NavBarStyle.style1,
      );
  }
}
