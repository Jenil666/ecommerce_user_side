import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:get/get.dart';

import '../modal/cart_screen_model.dart';

class CartScreenController extends GetxController
{
  RxList<CartModal> cartData = <CartModal>[].obs;
  String id="";
  List addToCart = [];
  // RxList cartProductId = [].obs;
  RxBool buyButtonCircularPRogressIndicator = false.obs;
  // void getIdOfProducts() async {
  //   DocumentSnapshot documentSnapshot = await FireBaseHelper.fireBaseHelper.readCart();
  //   Map m1 = documentSnapshot.data() as Map;
  //   var list = m1['Product Id'];
  //   cartProductId.value = list;
  // }

}