
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/screens/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_user_side/screens/cart/modal/cart_screen_model.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartScreenController getxCartScreenController = Get.put(CartScreenController());
  MasterController getxMasterController = Get.put(MasterController());
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxCartScreenController.getIdOfProducts();
  }
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffF7F6F4),
          // appBar: AppBar(title: Text("Cart Screen")),
          body: Obx(
            () =>  getxCartScreenController.cartProductId.isNotEmpty?StreamBuilder(
              stream: FireBaseHelper.fireBaseHelper.getProductsBasedOnProductId(getxCartScreenController.cartProductId),
              builder: (context, snapshot) {
                if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
                else if(snapshot.hasData)
                {
                  QuerySnapshot? snapData = snapshot.data;
                  getxCartScreenController.cartData.clear();
                  for(var x in snapData!.docs)
                  {
                    Map data = x.data() as Map;
                    CartModal modalData = CartModal(
                      id: x.id,
                      description: data['Description'],
                      price: data['Price'],
                      company: data['Company'],
                      discount: data['Discount'],
                      discountedPrice: data['Discounted Price'],
                      quantity: data['Quantity'],
                      image: data['image'],
                      name: data['Name'],
                      category: data['Category'],
                    );
                    getxCartScreenController.cartData.add(modalData);
                  }
                  return Obx(
                    () =>  ListView.builder(
                      itemCount: getxCartScreenController.cartData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 10.h,
                          width: 100.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xdbe5e5e5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: SizedBox(
                            height: 8.h,
                            child: Row(
                              children: [
                                Container(
                                    height: 8.h,
                                    width: 8.h,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    // child: CachedNetworkImage(imageUrl: "${cartData[index].image}"),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(10), child: CachedNetworkImage(
                                        progressIndicatorBuilder: (context, url, progress) => const Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
                                        imageUrl: "${getxCartScreenController.cartData[index].image}",fit: BoxFit.cover),)),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${getxCartScreenController.cartData[index].name}",style: TextStyle(fontSize: 12.sp),),
                                    Text("₹${getxCartScreenController.cartData[index].price}",style: TextStyle(fontSize: 10.sp,color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const Spacer(),
                                TextButton(onPressed: () async {
                                  getxCartScreenController.cartProductId.removeAt(index);
                                }, child: Text("Remove",style: TextStyle(color: Colors.deepOrange,fontSize: 8.sp),),)
                              ],
                            ),
                          ),
                        );
                      },),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },): Center(child: Container()),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            // ignore: unrelated_type_equality_checks
            child: Obx(() =>  getxCartScreenController.buyButtonCircularPRogressIndicator == false? Text("Buy"):const CircularProgressIndicator(color: Colors.white,)),
            onPressed: () {
              getxCartScreenController.buyButtonCircularPRogressIndicator.value = true;
              getxMasterController.totalAmount(getxCartScreenController.cartData);
              // ignore: unrelated_type_equality_checks
              if(getxMasterController.totalAmountProcess == true && getxMasterController.total.value == 0)
                {
                  Get.snackbar("ECommerce","Provider products");
                }
              // ignore: unrelated_type_equality_checks
              else if(getxMasterController.totalAmountProcess == true && getxMasterController.total.value != 0)
                {
                  getxCartScreenController.buyButtonCircularPRogressIndicator.value = false;
                  Get.toNamed('/pay');
                }
          },),
        ),
      );
  }
}
