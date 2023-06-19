import 'package:ecommerce_user_side/screens/userDetails/controller/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetaails extends StatefulWidget {
  const UserDetaails({super.key});

  @override
  State<UserDetaails> createState() => _UserDetaailsState();
}

class _UserDetaailsState extends State<UserDetaails> {
  UserDetailsController getxUserDetailsController =
      Get.put(UserDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxUserDetailsController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Detais Screen"),
        ),
        body: Obx(
          () =>  Column(
            children: [
              Text("${getxUserDetailsController.name}"),
              Text("${getxUserDetailsController.email}"),
              Text("${getxUserDetailsController.number}"),
              Text("${getxUserDetailsController.address}"),
              Image.network("${getxUserDetailsController.photo}"),
            ],
          ),
        ),
      ),
    );
  }
}
