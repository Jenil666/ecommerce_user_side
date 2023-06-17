import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/screens/buy/controller/buy_screen_controller.dart';
import 'package:ecommerce_user_side/screens/buy/modal/buyModal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/fire_base_helper.dart';

class BuyProductScreen extends StatefulWidget {
  const BuyProductScreen({super.key});

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  BuyScreenController getxBuyScreenController = Get.put(BuyScreenController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxBuyScreenController.getBuyDataOfUser();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xffF7F6F4),
      body: Obx(
        () =>  getxBuyScreenController.data.isNotEmpty?StreamBuilder(
        stream: FireBaseHelper.fireBaseHelper.getProductsBasedOnProductId(getxBuyScreenController.data),
        builder: (context, snapshot) {
        if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
        else if(snapshot.hasData)
          {
            QuerySnapshot? querySnapshot = snapshot.data;
            var map = querySnapshot!.docs;
           List<BuyModal> productData = [];
           for(var x in querySnapshot.docs)
             {
               Map data = x.data() as Map;
               BuyModal m1 = BuyModal(
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
               productData.add(m1);
             }
            return ListView.builder(
              itemCount:  productData.length,
              itemBuilder: (context, index) {
              return Container(
                height: 33.h,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xdbe5e5e5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  Column(
                  children: [
                    Container(
                      height: 25.h,
                        width: 100.w,
                        child: CachedNetworkImage(imageUrl: "${productData[index].image}",fit: BoxFit.fill,progressIndicatorBuilder: (context, url, progress) =>  Center(child: const CircularProgressIndicator(color: Colors.deepOrange,)),)),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 5.h,
                      width: 100.w,
                      child: Row(
                        children: [
                          Text('${productData[index].name}',style: TextStyle(fontSize: 12.sp),),
                          Spacer(),
                          Text('${productData[index].price}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.deepOrange)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },);
          }
        return Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
    },):Center(child: CircularProgressIndicator()),
      ),));
  }
}
