import 'package:get/get.dart';

import '../screens/ReadData/modal/read_data_modal_screeen.dart';
import '../screens/cart/controller/cart_screen_controller.dart';
import '../screens/cart/modal/cart_screen_model.dart';

class MasterController extends GetxController {

  bool getGeneralInfo = false;
  List<HotSalesModal> hotSalesData = [];
  RxInt total = 0.obs;
  RxBool totalAmountProcess = false.obs;
  void totalAmount(List<CartModal> data)
  {
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
}
