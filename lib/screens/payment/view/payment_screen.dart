import 'package:ecommerce_user_side/screens/buy/controller/buy_screen_controller.dart';
import 'package:ecommerce_user_side/screens/payment/controller/payment_screen_controller.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../cart/controller/cart_screen_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentScreenContrller getxPaymntScreenControler = Get.put(PaymentScreenContrller());
  MasterController getxMasterController = Get.put(MasterController());
  CartScreenController getxCartScreenController = Get.put(CartScreenController());
  BuyScreenController getxBuyScreenController = Get.put(BuyScreenController());
@override

  // int index = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                height: 47,
                width: 47,
                child: Image.asset("${getxPaymntScreenControler.backButton}")),
          ),
        ),
        backgroundColor: Color(0xffF7F6F4),
        body: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Shipping method",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 6.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: Color(0xff3F4343),
                    borderRadius: BorderRadius.circular(3.h)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        getxPaymntScreenControler.txtColor.value =
                            !getxPaymntScreenControler.txtColor.value;
                      },
                      child: Obx(
                        () => Container(
                          height: 5.h,
                          width: 44.w,
                          alignment: Alignment.center,
                          child: Text(
                            "Home delivery",
                            style: TextStyle(
                                color:
                                    getxPaymntScreenControler.txtColor.value ==
                                            false
                                        ? Color(0xff3F4343)
                                        : Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: getxPaymntScreenControler.txtColor.value ==
                                      false
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(3.h)),
                        ),
                      ),
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          getxPaymntScreenControler.txtColor.value =
                              !getxPaymntScreenControler.txtColor.value;
                        },
                        child: Container(
                          height: 5.h,
                          width: 44.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: getxPaymntScreenControler.txtColor.value ==
                                      false
                                  ? Color(0xff3F4343)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(3.h)),
                          child: Text(
                            "Pick up in Stope",
                            style: TextStyle(
                                color:
                                    getxPaymntScreenControler.txtColor.value ==
                                            false
                                        ? Colors.white
                                        : Color(0xff3F4343)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Select your payment method",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 14.h,
                    child: Image.asset(
                      "assets/images/visa_card.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 14.h,
                    child: Image.asset("assets/images/visa_card_2.png",
                        fit: BoxFit.fill),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "+ Add new",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 7.h,
                    child: Image.asset("assets/images/g_pay.png"),
                  ),
                  Container(
                    height: 7.h,
                    child: Image.asset("assets/images/apple_pay.png"),
                  ),
                  Container(
                    height: 7.h,
                    child: Image.asset("assets/images/pay_pal.png"),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(20),
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.h),
                      topLeft: Radius.circular(5.h))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Subtotal "),
                      Text("(${getxCartScreenController.cartData.length} items)"),
                      Spacer(),
                      Obx(() =>  getxMasterController.total == 0? CircularProgressIndicator(color: Colors.deepOrange,):Text("${getxMasterController.total}"))
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [Text("Shipping Cost"), Spacer(), Text("Free")],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text("Total"),
                      Spacer(),
                      Text(
                        "${getxMasterController.total}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      bool check = await FireBaseHelper.fireBaseHelper.buyProductRecords(getxCartScreenController.cartProductId);
                      // getxCartScreenController.
                      if(check == true)
                        {
                          Get.snackbar("Ecommerce", "Products Are Deployed For Shipping");
                          getxCartScreenController.cartProductId.clear();
                          FireBaseHelper.fireBaseHelper.addToCart(productId: getxCartScreenController.cartProductId);
                          getxCartScreenController.cartData.clear();
                          getxBuyScreenController.getBuyDataOfUser();
                        }
                    },
                    child: Container(
                      height: 5.h,
                      width: 100.w,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      child: Obx(
                        () => getxCartScreenController.buyButtonCircularPRogressIndicator == false?Text("Finalize Purchase",
                          style: TextStyle(color: Colors.white),
                        ):CircularProgressIndicator(color: Colors.white,),
                  ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
