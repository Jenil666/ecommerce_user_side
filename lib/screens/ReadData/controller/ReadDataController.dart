
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/screens/ReadData/modal/read_data_modal_screeen.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../utils/fire_base_helper.dart';

class ReadDataController extends GetxController
{
  // ToDo Images Variable
  String search = "assets/images/search.png";
  String notification = "assets/images/notification.png";
  String offerContainer = "assets/images/offerContainer.png";
  String headPhones = "assets/images/headphones.png";
  String macbook = "assets/images/macbook.png";
  String tws = "assets/images/tws.png";
  String shippingPng = "assets/images/shippingPng.png";


  //ToDo variable Unknown
  RxList categoryName  = [].obs;
  RxString selectedCategory = 'all'.obs;
  getCategory() async{
    QuerySnapshot querySnapshot = await FireBaseHelper.fireBaseHelper.readCategory();
    List m1 = querySnapshot.docs ;
    categoryName.value = m1[0]['data'];
  }
  PersistentTabController? preController;
  void controller()
  {
  preController = PersistentTabController(initialIndex: 0);
}
}