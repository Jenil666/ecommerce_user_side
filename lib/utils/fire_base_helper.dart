import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/screens/cart/controller/cart_screen_controller.dart';
import 'package:ecommerce_user_side/utils/master_controller.dart';
import 'package:ecommerce_user_side/utils/shr_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/generalDataentry/modal/user_data_modal.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

import '../screens/product_details/controller/product_details_controller.dart';

class FireBaseHelper {
  MasterController getxMasterController = Get.put(MasterController());
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore inse = FirebaseFirestore.instance;

  //Todo SignIn
  Future<bool?> createAccount({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (value) {
        return true;
      },
    ).catchError((e) {
      print("===============================");
      print(e);
      return false;
    });
  }

  Future<bool?> read({required email, required password}) async {
    bool? msg;
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then(
          (value) {
        msg = true;
      },
    ).catchError(
          (e) {
        msg = false;
      },
    );

    return msg;
  }

  bool storeLogin() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool?> signOut() async {
    bool? check;
    Shr.shr.setData(false);
    await firebaseAuth.signOut().then((value) async {
      await GoogleSignIn().signOut();
      getxMasterController.getGeneralInfo = false;
      return check = true;
    });
    return check;
  }

  sinhInThroughGoogle() async {
    bool? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await user?.authentication;

    var crd = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = true)
        .catchError((e) => msg = false);
    return msg;
  }

  //Todo App
  Stream<QuerySnapshot<Map<String, dynamic>>> readData(cate) {
    if(cate == "all")
      {
        return inse.collection('Product').snapshots();
      }
    else
      {
        return inse.collection('Product').where("Catedory",isEqualTo: "$cate").snapshots();
      }
  }

  User getUserData() {
    User? user = firebaseAuth.currentUser;
    String? emailail = user!.email;
    return user;
  }

  Future<String?> getFmcToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? fmcToken = await firebaseMessaging.getToken();
    return fmcToken;
  }

  void collectionOfUserData(UserDataModal data) {
    inse.collection("User").add({
      "Name": data.name,
      "Mobile Number": data.mobileNumber,
      "Email": data.email,
      "FmcToken": data.fmcToken,
      "Address": data.address,
      "Uid": data.uid,
    });
  }

  User? userData() {
    User? user = firebaseAuth.currentUser;
    return user;
  }

   Future<int> addToCart({List? listOfProductId,bool? addinCart}) async {
    MasterController getxMasterController = Get.put(MasterController());
    ProductDetailsController getxProductDetailsController = Get.put(ProductDetailsController());

    bool cartCheck = true;
    getxProductDetailsController.addToCart.value = true;
    User? user = userData();
    Set products = {};
    List data = [];
    int lastIndex = 0;

    products.addAll(getxMasterController.cartProductId);
    products.addAll(listOfProductId!);
    data.addAll(products);
    lastIndex = data.length;

    for (int i = 0; i < getxMasterController.cartProductId.length; i++) {
      if (getxMasterController.cartProductId[i] == data[lastIndex-1]) {
        cartCheck = false;
        break;
      }
    }
    getxMasterController.getCartData();

    if(addinCart == false)
      {
        return inse.collection("Cart").doc('${user?.uid}').set({"Product Id": listOfProductId
        }).then((value) {
          // add to cart
          getxProductDetailsController.addToCart.value = false;
          return 2;
        });
      }
    if (cartCheck == true && addinCart == true) {
      if (user?.uid != null) {
         return inse.collection("Cart").doc('${user?.uid}').set({"Product Id": data
        }).then((value) {
          // add to cart
           getxProductDetailsController.addToCart.value = false;
           return 2;
        });
      }
      else {
        data.clear();
        addToCart();
        // fail to add in cart
        getxProductDetailsController.addToCart.value = false;
        return 3;
      }
    }
    else {
        if(cartCheck == false)
          {
            // available in cart List
            getxProductDetailsController.addToCart.value = false;
            return 4;
          }
        else
          {
            // error unknown
            getxProductDetailsController.addToCart.value = false;
            return 5;
          }
      }
   }

  Future<DocumentSnapshot<Map<String, dynamic>>> readCart() {
    User? user = firebaseAuth.currentUser;
    return inse.collection("Cart").doc("${user!.uid}").get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsBasedOnProductId(List id)  {
    return  FirebaseFirestore.instance.collection('Product').where(FieldPath.documentId, whereIn: id).snapshots();
  }

  bool buyProductRecords(List data) {
    CartScreenController getx = Get.put(CartScreenController());
    getx.buyButtonCircularPRogressIndicator.value = true;
    User? user = userData();
    try
    {
      for(int i=0;i<data.length;i++) {
        User? user = userData();
        inse.collection("Requester For Purchase").add({
          "Uid":user!.uid,
          "products":data[i]
        });
      }
      getx.buyButtonCircularPRogressIndicator.value = false;
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readBuyData() {
    User? user = userData();
    return inse.collection('Requester For Purchase').where('Uid',isEqualTo: '${user!.uid}').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readCategory() {
    return inse.collection("Category").get();
  }
}