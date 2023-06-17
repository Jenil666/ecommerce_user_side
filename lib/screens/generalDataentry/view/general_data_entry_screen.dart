import 'package:ecommerce_user_side/screens/generalDataentry/controller/general_data_enter_screen_controller.dart';
import 'package:ecommerce_user_side/screens/generalDataentry/modal/user_data_modal.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/shr_helper.dart';

class GeneralDataEntryScreen extends StatefulWidget {
  const GeneralDataEntryScreen({super.key});

  @override
  State<GeneralDataEntryScreen> createState() => _GeneralDataEntryScreenState();
}

class _GeneralDataEntryScreenState extends State<GeneralDataEntryScreen> {
  MasterController getxMasterController = Get.put(MasterController());
  GeneralDataEntryScreenController getxGeneralDataEntryScreenController = Get.put(GeneralDataEntryScreenController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getData();
  }
  Future<void> getData()
  async {
    getxGeneralDataEntryScreenController.fmcToken = await FireBaseHelper.fireBaseHelper.getFmcToken() as String?;
    getxGeneralDataEntryScreenController.email = await FireBaseHelper.fireBaseHelper.getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: Image.asset("${getxGeneralDataEntryScreenController.backGround}",fit: BoxFit.fill,),
            ),
            Transform.translate(
                offset: Offset(0, 24.h),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Required Info 😊😊😊",
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
                    controller: getxGeneralDataEntryScreenController.txtName,
                    style: TextStyle(color: Color(0xff667085)),
                    cursorColor: Color(0xff667085),
                    decoration: InputDecoration(
                        hintText: "Enter Name",
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
              offset: Offset(0, 44.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: getxGeneralDataEntryScreenController.txtMobileNumber,
                    style: TextStyle(color: Color(0xff667085)),
                    cursorColor: Color(0xff667085),
                    decoration: InputDecoration(
                        hintText: "Enter Number",
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
              offset: Offset(0, 54.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: getxGeneralDataEntryScreenController.txtAddress,
                    style: TextStyle(color: Color(0xff667085)),
                    cursorColor: Color(0xff667085),
                    decoration: InputDecoration(
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     // getxRegisterScreenController.txtEmail.clear();
                        //   },
                        //   icon: Icon(
                        //     Icons.cancel_outlined,
                        //     color: Color(0xff667085),
                        //     size: 20,
                        //   ),
                        // ),
                        hintText: "Enter Address",
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
              offset: Offset(35.w, 74.h),
              child: ElevatedButton(onPressed: () {
                if((getxGeneralDataEntryScreenController.txtAddress.text!="")&&(getxGeneralDataEntryScreenController.txtName.text!="")&&(getxGeneralDataEntryScreenController.txtMobileNumber.text!=""))
                  {
                    Get.toNamed('navagation');
                    Get.snackbar("Jenil", "Login SuccessFully");
                    getxMasterController.getGeneralInfo = true;
                    UserDataModal data = UserDataModal(
                      name:getxGeneralDataEntryScreenController.txtName.text,
                      email: getxGeneralDataEntryScreenController.email,
                      address: getxGeneralDataEntryScreenController.txtAddress.text,
                      fmcToken: getxGeneralDataEntryScreenController.fmcToken,
                      mobileNumber: getxGeneralDataEntryScreenController.txtMobileNumber.text,
                    );
                    FireBaseHelper.fireBaseHelper.collectionOfUserData(data);
                    Shr.shr.setData(true);
                  }
                else
                  {
                    Get.snackbar("Ecommerce", "Provide Required Information");
                  }
              }, child: Text("Continue"))
            ),
          ],
        ),
      ),
    );
  }
}
