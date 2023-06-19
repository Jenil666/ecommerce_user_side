import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controller/sign_in_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    MasterController getxMasterController = Get.put(MasterController());
    SignInController getxSignInScreenController = Get.put(SignInController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset("${getxSignInScreenController.backGround}",fit: BoxFit.cover,),
            ),
            Transform.translate(
                offset: Offset(0, 12.h),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Sign In to Explore 😄😄😄",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp,color: Colors.black),))),
            Transform.translate(
              offset: Offset(0,22.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: getxSignInScreenController.txtEmail,
                    style: TextStyle(color: Color(0xff667085)),
                    cursorColor: Color(0xff667085),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: () {
                        getxSignInScreenController.txtEmail.clear();
                      }, icon: Icon(Icons.cancel_outlined,color: Color(0xff667085),size: 20,),),
                      hintText: "Enter Email",
                      hintStyle: TextStyle(color: Color(0xff4F555A)),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 31.5.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () =>  TextField(
                      enableSuggestions: true,
                      obscureText: getxSignInScreenController.showPassword==true?false:true,
                      controller: getxSignInScreenController.txtPasseord,
                      style: TextStyle(color: Color(0xff667085)),
                      cursorColor: Color(0xff667085),
                      decoration: InputDecoration(
                          suffixIcon: Obx(
                            () => IconButton(onPressed: () {
                              getxSignInScreenController.showPassword.value =! getxSignInScreenController.showPassword.value;
                            }, icon: Icon(getxSignInScreenController.showPassword==false?Icons.visibility_off_outlined:Icons.visibility_outlined,color: Color(0xff667085),size: 20,),),
                          ),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Color(0xff4F555A)),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none
                        )
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 45.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () =>  InkWell(
                  onTap:() async {
                    getxSignInScreenController.checkCircularProgressIndicator.value = true;
                    if(getxSignInScreenController.buttonData.value == "Tap To Continue")
                      {
                        getxSignInScreenController.checkCircularProgressIndicator.value = false;
                        Get.offAllNamed('/generalInfo');
                        // Get.snackbar("Done","Done");
                      }
                    if((getxSignInScreenController.txtEmail.text =="") || (getxSignInScreenController.txtPasseord.text ==""))
                      {
                        getxSignInScreenController.checkCircularProgressIndicator.value = false;
                        Get.snackbar("Jenil", "Enter Valid password or email");
                      }
                    else
                      {
                        bool? msg = await FireBaseHelper.fireBaseHelper.read(email: getxSignInScreenController.txtEmail.text, password: getxSignInScreenController.txtPasseord.text);
                        if(msg == true)
                          {
                            // Get.offAllNamed('/navagation');
                            getxSignInScreenController.checkCircularProgressIndicator.value = false;
                            getxSignInScreenController.buttonData.value = "Tap To Continue";
                            Get.snackbar("Jenil", "Verification Completed");
                          }
                        else
                          {
                            getxSignInScreenController.checkCircularProgressIndicator.value = false;
                            getxSignInScreenController.buttonData.value = "Sign In";
                            Get.snackbar("Jenil", "Enter valid Id or Password");
                          }
                      }
                  },
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      child: getxSignInScreenController.checkCircularProgressIndicator.value==false?Text("${getxSignInScreenController.buttonData.value}",style: TextStyle(color: Colors.white,fontSize: 13.sp),):CircularProgressIndicator(color: Colors.white,),
                      decoration: BoxDecoration(
                        color: Color(0xff4461F2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 58.h),
              child: Divider(
                // color: Colors.red,
                indent: 10,
                endIndent: 280,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 58.h),
              child: Divider(
                // color: Colors.red,
                indent: 280,
                endIndent: 10,
              ),
            ),
            Transform.translate(
                offset: Offset(37.w, 57.5.h),
                child: Text("Or continue with",style: TextStyle(color: Color(0xffACADAC)),)),
            Transform.translate(
              offset: Offset(0, 65.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      bool? check = await FireBaseHelper.fireBaseHelper.sinhInThroughGoogle();
                      if(check == true)
                        {
                          Get.offAllNamed('/navagation');
                        }
                    },
                    child: Container(
                      height: 7.h,
                      child: Image.asset("${getxSignInScreenController.googleButton}"),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                          ]
                      ),
                    ),
                  ),
                  Container(
                    height: 7.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                      ]
                    ),
                    alignment: Alignment.center,
                    child:Image.asset("${getxSignInScreenController.appleButton}",height: 3.h,),
                  ),
                  Container(
                    height: 7.h,
                    child: Image.asset("${getxSignInScreenController.facebookButton}"),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 2)
                        ]
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0,80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.offNamed('/register');
                      },
                      child: Text("if you don't have an account\nyou can Register here!",style: TextStyle(color: Color(0xff4461F2),fontSize: 13.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
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
