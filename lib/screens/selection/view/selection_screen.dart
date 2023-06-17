import 'package:ecommerce_user_side/screens/register/controller/register_screen_controller.dart';
import 'package:ecommerce_user_side/screens/selection/controller/selection_screen_controller.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  MasterController getxMasterController = Get.put(MasterController());
  SelectionScreenController getxSelectionScreenController = Get.put(SelectionScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset("${getxSelectionScreenController.backGround}",fit: BoxFit.cover,),
            ),
            Container(
              // height: 100.h,
              // width: 100.w,
              child: Image.asset("${getxSelectionScreenController.backGroundForSelectionScreen}",fit: BoxFit.cover,),
            ),
            Transform.translate(
              offset: Offset(0, 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed("/signIn");
                    },
                    child: Container(
                      height: 5.h,
                      width: 23.w,
                      alignment: Alignment.center,
                      child: Text("Sign In",style: TextStyle(color: Colors.white),),
                      decoration: BoxDecoration(
                        color: Color(0xff4461F2),
                        borderRadius: BorderRadius.circular(3.h)
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  InkWell(
                    onTap: () {
                      Get.toNamed("/register");
                    },
                    child: Container(
                      height: 5.h,
                      width: 25.w,
                      alignment: Alignment.center,
                      child: Text("Register",style: TextStyle(color: Color(0xff4461F2)),),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.h)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
                offset: Offset(85.w, 5.h),
                child: Text("Jenil",style: GoogleFonts.babylonica(color: Colors.black12,fontSize: 18.sp,fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
