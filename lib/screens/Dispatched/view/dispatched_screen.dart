import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_side/screens/Dispatched/controller/dispatch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DispatchedScreen extends StatefulWidget {
  const DispatchedScreen({super.key});

  @override
  State<DispatchedScreen> createState() => _DispatchedScreenState();
}

class _DispatchedScreenState extends State<DispatchedScreen> {
  DispatchedController getxDispatchController = Get.put(DispatchedController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxDispatchController.getDispatchData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
              () =>  ListView.builder(
            itemCount: getxDispatchController.orderData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: ExpansionTile(
                    iconColor: Colors.orangeAccent,
                    textColor: Colors.orange,
                    childrenPadding: EdgeInsets.all(20),
                    title: Row(
                      children: [
                        Container(
                          height: 6.h,
                          width: 6.h,
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                )),
                            imageUrl: "${getxDispatchController.orderData[index].productImage}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${getxDispatchController.orderData[index].productName}"),
                            Text("${getxDispatchController.orderData[index].productPrice}"),
                          ],
                        ),
                      ],
                    )),
              );
            },),
        ),
      ),
    );
  }
}
