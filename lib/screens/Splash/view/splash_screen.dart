import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/master_controller.dart';
import '../../../utils/shr_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  bool? check;
  MasterController getxMasterController = Get.put(MasterController());
  void initState() {
    // TODO: implement initState
    super.initState();
    check = FireBaseHelper.fireBaseHelper.storeLogin();
    getxMasterController.getCartData();
  }
  @override
  Widget build(BuildContext context) {
    MasterController getxMasterController = Get.put(MasterController());
    Future.delayed(Duration(seconds: 2),() async {
      bool? userData = await Shr.shr.readData();
      if(check == true && userData == true )
        {
          Get.offNamed('/navagation');
        }
      else
        {
          Get.offNamed('/select');
        }
    },);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: Center(
        child: Text("Jenil",style: GoogleFonts.babylonica(color: Colors.white,fontSize: 50.sp),),
      ),
    ),);
  }
}
