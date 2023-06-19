import 'dart:async';

import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../generalDataentry/controller/general_data_enter_screen_controller.dart';

class UserDetailsController extends GetxController
{
  GeneralDataEntryScreenController getxGeneralDataEntryScreenController = Get.put(GeneralDataEntryScreenController());
  var data = FireBaseHelper.fireBaseHelper.getUserData();
  RxString name = "".obs;
  RxString email = "".obs;
  RxString number = "".obs;
  RxString photo = "".obs;
  RxString address = "".obs;
  void getData()
  {
    Timer(Duration(seconds: 3), () {
    name.value = data.displayName!;
    email.value = data.email!;
    number.value = getxGeneralDataEntryScreenController.txtMobileNumber.text;
    address.value = getxGeneralDataEntryScreenController.txtAddress.text;
    number.value = getxGeneralDataEntryScreenController.txtMobileNumber.text;
    photo.value = data.photoURL!;
    });
  }
}