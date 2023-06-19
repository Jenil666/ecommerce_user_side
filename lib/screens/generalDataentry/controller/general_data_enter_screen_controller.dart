import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralDataEntryScreenController extends GetxController {
  //ToDo image Variables
  String backGround = "assets/login_images/back_ground.png";

  // todo data entry variables
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  //todo variables for user data
  String? fmcToken;
  String? email;
  String? uid;
}
