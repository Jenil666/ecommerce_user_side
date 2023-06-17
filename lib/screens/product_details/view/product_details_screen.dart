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
    ProductDetailsController getxProductDetailsController =
        Get.put(ProductDetailsController());
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
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("FREE SHIPPING",style: TextStyle(color: Color(0xff909090),fontSize: 10.sp),),
                          Spacer(),
                          Image.asset("${getxProductDetailsController.star}",height: 15),
                          Text("Comming soon",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11.sp),),
                          // Text("${getxMasterController.hotSalesData[index].ratings}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11.sp),),
                          Text("Comming soon",style: TextStyle(color: Color(0xff909090),fontSize: 8.sp),),
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
                          Text("${getxMasterController.hotSalesData[index].price}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange,fontSize: 18.sp),),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:() {
                              print("==================================== id");
                              print(getxMasterController.hotSalesData[index].id);
                              getxCartScreenController.cartProductId.add(getxMasterController.hotSalesData[index].id);
                              FireBaseHelper.fireBaseHelper.addToCart(productId: getxCartScreenController.cartProductId);
                            },
                            child: Container(
                              height: 4.5.h,
                              width: 30.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Add to Cart",style: TextStyle(color: Colors.black45),),
                                  Icon(Icons.shopping_cart,size: 15,color: Colors.black45,),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xffC4C4C4))
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              getxCartScreenController.cartProductId.add(getxMasterController.hotSalesData[index].id);
                              FireBaseHelper.fireBaseHelper.addToCart(productId: getxCartScreenController.cartProductId);
                              Get.back();
                            },
                            child: Container(
                              height: 5.5.h,
                              width: 50.w,
                              alignment: Alignment.center,
                              child: Text("Buy Now",style: TextStyle(fontSize: 12.sp,color:Colors.white),),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.h),topRight: Radius.circular(8.h),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
