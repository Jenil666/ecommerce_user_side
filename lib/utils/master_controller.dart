import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../screens/ReadData/modal/read_data_modal_screeen.dart';
import '../screens/cart/controller/cart_screen_controller.dart';
import '../screens/cart/modal/cart_screen_model.dart';
import 'fire_base_helper.dart';

class MasterController extends GetxController {

  bool getGeneralInfo = false;
  List<HotSalesModal> hotSalesData = [];
  RxList cartProductId = [].obs;
  RxInt total = 0.obs;
  RxBool totalAmountProcess = false.obs;
  RxList buyData = [].obs;
  void totalAmount(List<CartModal> data) {
    CartScreenController getxCartScreenController = Get.put(CartScreenController());
    total.value = 0;
    totalAmountProcess.value = false;
    for(int i =0;i<data.length;i++)
    {
      int amount = int.parse("${data[i].price}");
      total.value = amount + total.value;
    }
    totalAmountProcess.value = true;
    getxCartScreenController.buyButtonCircularPRogressIndicator.value = false;
  }
  Future<void> getCartData()
  async {
      DocumentSnapshot documentSnapshot = await FireBaseHelper.fireBaseHelper.readCart();
      Map m1 = documentSnapshot.data() as Map;
      var list = m1['Product Id'];
      cartProductId.value = list;
    }
  Future<void> getBuyDataOfUser()
  async {
    List dataarray = [];
    QuerySnapshot? querySnapshort = await FireBaseHelper.fireBaseHelper.readBuyData();
    var map = querySnapshort.docs;
    dataarray.clear();
    for(int i =0;i<map.length;i++ )
    {
      dataarray.add(map[i]['products']);
    }
    buyData.clear();
    for(int i =0;i<dataarray.length;i++ )
    {
      for(int j =0;j<dataarray[i].length;j++)
      {
        buyData.add(dataarray[i][j]);
      }
    }
  }
}
