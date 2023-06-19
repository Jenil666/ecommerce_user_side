import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/screens/ReadData/controller/ReadDataController.dart';
import 'package:ecommerce_user_side/screens/ReadData/modal/read_data_modal_screeen.dart';
import 'package:ecommerce_user_side/screens/buy/controller/buy_screen_controller.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/notification_helper.dart';

class ReadDataScreen extends StatefulWidget {
  const ReadDataScreen({Key? key}) : super(key: key);

  @override
  State<ReadDataScreen> createState() => _ReadDataScreenState();
}

class _ReadDataScreenState extends State<ReadDataScreen> {
  ReadDataController getxReadDataController = Get.put(ReadDataController());
  MasterController getxMasterController = Get.put(MasterController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BuyScreenController getx = Get.put(BuyScreenController());
    getx.getBuyDataOfUser();
    getxReadDataController.getCategory();
    NotificationHelper.notificationHelper.initFireBaseMsg();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF7F6F4),
        body: Obx(
          () =>  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(2.w),
                    padding: EdgeInsets.all(3.w),
                    height: 5.5.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.w)
                    ),
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(1.w, 0.2.w),
                          child: Container(
                          height: 8.w,
                              width: 7.w,
                              child: Image.asset("${getxReadDataController.search}")),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool? check = await FireBaseHelper.fireBaseHelper.signOut();
                      if(check==true)
                        {
                          Get.offAllNamed("/select");
                        }
                    },
                    child: Container(
                      height: 5.5.h,
                      width: 7.h,
                      child: Icon(Icons.notifications_outlined,size: 4.h,color: Colors.black26,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  Get.toNamed("/offer");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Image.asset("${getxReadDataController.offerContainer}"),
                ),
              ),
              getxReadDataController.categoryName.isNotEmpty?Container(
                height: 6.5.h,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        getxReadDataController.selectedCategory.value = "all";
                      },
                      child: Container(
                        margin: EdgeInsets.all(1.h),
                        padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
                        height: 6.5.h,
                        alignment: Alignment.center,
                        child: Text("All",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                          border: Border.all(color: Color(0xffCFCFCF),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              getxReadDataController.selectedCategory.value ="${getxReadDataController.categoryName[index]}" ;
                            },
                            child: cont(category: getxReadDataController.categoryName[index]));
                      },itemCount: getxReadDataController.categoryName.length,),
                    ),
                  ],
                ),
              ):Container(height: 6.5.h,alignment: Alignment.center,child: CircularProgressIndicator(color: Colors.deepOrange,),),
              Row(
                children: [
                  SizedBox(width: 4.w,),
                  Text("Hot Sales",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp),)
                ],
              ),
              Container(
                // color: Colors.red,
                height: 30.h,
                child: StreamBuilder(
                  stream: FireBaseHelper.fireBaseHelper.readData(getxReadDataController.selectedCategory),
                  builder: (context, snapshot) {
                    getxMasterController.hotSalesData.clear();
                  if(snapshot.hasError)
                    {
                      return Text("${snapshot.error}");
                    }
                  if(snapshot.hasData)
                    {
                      QuerySnapshot? snapData = snapshot.data;
                      for(var x in snapData!.docs)
                        {
                          Map? data = x.data() as Map;

                          String category = data['Catedory'];
                          String company = data['Company'];
                          String description = data['Description'];
                          String discount = data['Discount'];
                          String  discountedPrice = data['Discounted Price'];
                          String  name= data['Name'];
                          String  price= data['Price'];
                          String  quantity = data['Quantity'];
                          String id = x.id;
                          String image = data['image'];
                          String review = data['Review'];
                          String totalReview = data['Total Review'];
                          HotSalesModal t1 = HotSalesModal(
                            description: description,
                            price: price,
                            name: name,
                            category: category,
                            company: company,
                            discount: discount,
                            discountedPrice: discountedPrice,
                            quantity: quantity,
                            id: id,
                            image: image,
                            review: review,
                            totalReview: totalReview
                          );
                          getxMasterController.hotSalesData.add(t1);
                        }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed("/details",arguments: index);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  height: 30.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xdbe5e5e5),
                                      borderRadius: BorderRadius.circular(3.h)
                                  ),
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15.h,
                                    width: 35.w,
                                    // color: Colors.red,
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator(color: Colors.deepOrange,)),
                                      imageUrl: "${getxMasterController.hotSalesData[index].image}",),
                                    // child: Text("Comming Soon"),
                                    // child: Image.asset("${getxMasterController.hotSalesData[index].img}"),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(2.h, 1.5.w),
                                child: Container(
                                  height: 5.5.h,
                                  width: 23.w,
                                  child: Image.asset('${getxReadDataController.shippingPng}'),
                                ),
                              ),
                              Transform.translate(
                                  offset: Offset(4.w, 23.h),
                                  child: Text("${getxMasterController.hotSalesData[index].name}",style: TextStyle(fontSize: 9.sp),)),
                              Transform.translate(
                                  offset: Offset(4.w, 25.h),
                                  child: Text("${getxMasterController.hotSalesData[index].price}",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),)),
                            ],
                          );
                        },itemCount: getxMasterController.hotSalesData.length,);
                    }
                  return Center(child: CircularProgressIndicator());
                },)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cont({category})
  {
    return Container(
      margin: EdgeInsets.all(1.h),
      padding: EdgeInsets.symmetric(horizontal: 2.h,vertical: 1.h),
      height: 2.h,
      alignment: Alignment.center,
      child: Text("$category",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: Color(0xffCFCFCF),),
      ),
    );
  }

}
