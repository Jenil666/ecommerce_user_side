import 'package:ecommerce_user_side/screens/register/controller/register_screen_controller.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  MasterController getxMastercontroller = Get.put(MasterController());
  RegisterScreenController getxRegisterScreenController =
      Get.put(RegisterScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                "${getxRegisterScreenController.backGround}",
                fit: BoxFit.cover,
              ),
            ),
            Transform.translate(
                offset: Offset(0, 24.h),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Create Account 😊😊😊",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.black),
                    ))),
            Transform.translate(
              offset: Offset(0, 34.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: getxRegisterScreenController.txtEmail,
                    style: TextStyle(color: Color(0xff667085)),
                    cursorColor: Color(0xff667085),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            getxRegisterScreenController.txtEmail.clear();
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Color(0xff667085),
                            size: 20,
                          ),
                        ),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Color(0xff4F555A)),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 43.5.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => TextField(
                      enableSuggestions: true,
                      obscureText:
                          getxRegisterScreenController.showPassword == true
                              ? false
                              : true,
                      controller: getxRegisterScreenController.txtPasseord,
                      style: TextStyle(color: Color(0xff667085)),
                      cursorColor: Color(0xff667085),
                      decoration: InputDecoration(
                          suffixIcon: Obx(
                            () => IconButton(
                              onPressed: () {
                                getxRegisterScreenController
                                        .showPassword.value =
                                    !getxRegisterScreenController
                                        .showPassword.value;
                              },
                              icon: Icon(
                                getxRegisterScreenController.showPassword ==
                                        false
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Color(0xff667085),
                                size: 20,
                              ),
                            ),
                          ),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: Color(0xff4F555A)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 57.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () =>  InkWell(
                    onTap: () async {
                      getxRegisterScreenController.chechCircularProgressIndicator.value = true;
                      bool? check;
                      if(getxRegisterScreenController.buttonText.value == "Tap To Continue")
                        {
                          // getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                          Get.offAllNamed("/generalInfo");
                        }
                      if((getxRegisterScreenController.txtPasseord.text == "") && (getxRegisterScreenController.txtEmail.text == ""))
                        {
                          getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                          Get.snackbar("Jenil", "Provide prooper email and password");
                        }
                      else
                        {
                          check = await FireBaseHelper.fireBaseHelper.createAccount(password: getxRegisterScreenController.txtPasseord.text,email: getxRegisterScreenController.txtEmail.text);
                          if(check == false && (getxRegisterScreenController.buttonText.value != "Tap To Continue"))
                          {
                            getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                            Get.snackbar("Jenil", 'Try with another username');
                          }
                          else if(check == true)
                          {
                            getxRegisterScreenController.chechCircularProgressIndicator.value = false;
                            // getxRegisterScreenController.buttonText.value = ""
                            Get.snackbar("Jenil", "Account Created");
                            // Get.toNamed("/signIn");
                            getxRegisterScreenController.buttonText.value = "Tap To Continue";
                          }
                        }
                    },
                    child: Container(
                      height: 7.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      child: getxRegisterScreenController.chechCircularProgressIndicator.value==false?Text(
                        "${getxRegisterScreenController.buttonText.value}",
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ):CircularProgressIndicator(color: Colors.white,),
                      decoration: BoxDecoration(
                          color: Color(0xff4461F2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.offNamed('/signIn');
                      },
                      child: Text(
                          "Already have an account\nyou can sign in here!",
                          style: TextStyle(
                              color: Color(0xff4461F2),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)),
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
