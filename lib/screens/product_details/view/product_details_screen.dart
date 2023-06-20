import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_side/screens/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_user_side/screens/product_details/controller/product_details_controller.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:ecommerce_user_side/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CartScreenController getxCartScreenController = Get.put(CartScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getxCartScreenController.getIdOfProducts();
  }
  @override
  Widget build(BuildContext context) {
    ProductDetailsController getxProductDetailsController = Get.put(ProductDetailsController());
    MasterController getxMasterController = Get.put(MasterController());
    int index = Get.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F6F4),
        // backgroundColor: Color(0xffE5E5E5),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: 47,
                        width: 47,
                        child: Image.asset(
                            '${getxProductDetailsController.backButton}')),
                  ),
                  Spacer(),
                  Container(
                      height: 47,
                      width: 47,
                      child: Image.asset(
                          '${getxProductDetailsController.likeButton}')),
                  SizedBox(
                    width: 2.h,
                  ),
                  Container(
                      height: 47,
                      width: 47,
                      child: Image.asset(
                          '${getxProductDetailsController.shareButton}')),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.h)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 200,
                      width: 200,
                      child: CachedNetworkImage(imageUrl: "${getxMasterController.hotSalesData[index].image}",progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),),),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Expanded(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.h),topRight: Radius.circular(8.h),),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("FREE SHIPPING",style: TextStyle(color: Color(0xff909090),fontSize: 10.sp),),
                          Spacer(),
                          Image.asset("${getxProductDetailsController.star}",height: 15),
                          Text("${getxMasterController.hotSalesData[index].review}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11.sp),),
                          // Text("${getxMasterController.hotSalesData[index].ratings}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11.sp),),
                          Text("(${getxMasterController.hotSalesData[index].totalReview})",style: TextStyle(color: Color(0xff909090),fontSize: 8.sp),),
                          // Text("(${getxMasterController.hotSalesData[index].reviewers})",style: TextStyle(color: Color(0xff909090),fontSize: 8.sp),),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        children: [
                          Text("${getxMasterController.hotSalesData[index].name}",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Container(
                        height: 10.h,
                        width: 100.w,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("${getxMasterController.hotSalesData[index].description}",overflow: TextOverflow.clip),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        children: [
                          Text("₹${getxMasterController.hotSalesData[index].price}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange,fontSize: 18.sp),),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () =>  InkWell(
                              onTap: () async {
                                getxCartScreenController.addToCart.clear();
                                getxProductDetailsController.addToCart.value == true;
                                // Timer(Duration(seconds: 2), () {getxProductDetailsController.addToCart.value == false;});
                                print("======================= clicked");
                                // getxCartScreenController.cartProductId.clear();
                                getxCartScreenController.addToCart.add(getxMasterController.hotSalesData[index].id);
                                int check = await FireBaseHelper.fireBaseHelper.addToCart(listOfProductId: getxCartScreenController.addToCart,addinCart: true);
                                if(check == 2)
                                  {
                                    print('===== = = = done');
                                    Get.snackbar("Ecommerce", "Data Added In Cart",onTap: (snack) {
                                      Get.toNamed('/cart');
                                    },);
                                  }
                                else if(check == 3)
                                  {
                                    Get.snackbar("Ecommerce", "Unable Add In Cart");
                                  }
                                else if(check == 4)
                                  {
                                    Get.snackbar("Ecommerce", "Product Alreade available In Your Cart",onTap: (snack) {
                                      Get.toNamed('/cart');
                                    },);
                                  }
                                else if(check == 5)
                                  {
                                    Get.snackbar("Ecommerce", "Unknoen Error Uccer");
                                  }
                              },
                              child: Container(
                                height: 5.5.h,
                                width: 84.w,
                                alignment: Alignment.center,
                                child: getxProductDetailsController.addToCart == false?Text("Add to cart",style: TextStyle(fontSize: 12.sp,color:Colors.white),):CircularProgressIndicator(color: Colors.white,),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
