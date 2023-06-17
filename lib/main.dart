import 'package:ecommerce_user_side/screens/ReadData/view/read_data_screen.dart';
import 'package:ecommerce_user_side/screens/Splash/view/splash_screen.dart';
import 'package:ecommerce_user_side/screens/buy/view/buy_product_screen.dart';
import 'package:ecommerce_user_side/screens/cart/view/cart_screen.dart';
import 'package:ecommerce_user_side/screens/generalDataentry/view/general_data_entry_screen.dart';
import 'package:ecommerce_user_side/screens/navagationBar/view/navagation_bar_screen.dart';
import 'package:ecommerce_user_side/screens/offer/view/offer_screen.dart';
import 'package:ecommerce_user_side/screens/payment/view/payment_screen.dart';
import 'package:ecommerce_user_side/screens/product_details/view/product_details_screen.dart';
import 'package:ecommerce_user_side/screens/register/view/register_screen.dart';
import 'package:ecommerce_user_side/screens/selection/view/selection_screen.dart';
import 'package:ecommerce_user_side/screens/sign_in/view/sign_in_screen.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:ecommerce_user_side/utils/notification_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.notificationHelper.initNotification();
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //    builder: (context) =>
           Sizer(
        builder: (context, orientation, deviceType) =>  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: '/buy',
          getPages: [
            GetPage(name: '/', page: () => SplashScreen(),transition: Transition.downToUp),
            GetPage(name: '/select', page: () => SelectionScreen(),transition: Transition.downToUp),
            GetPage(name: '/signIn', page: () => SignInScreen(),transition: Transition.downToUp),
            GetPage(name: '/register', page: () => RegisterScreen(),transition: Transition.downToUp),
            GetPage(name: '/generalInfo', page: () => GeneralDataEntryScreen(),transition: Transition.downToUp),
            GetPage(name: '/navagation', page: () => BottomNavagationScreen(),transition: Transition.downToUp),
            GetPage(name: '/data', page: () => ReadDataScreen(),transition: Transition.downToUp),
            GetPage(name: '/details', page: () => ProductDetails(),transition: Transition.downToUp),
            GetPage(name: '/offer', page: () => OfferScreen(),transition: Transition.downToUp),
            GetPage(name: '/pay', page: () => PaymentScreen(),transition: Transition.downToUp),
            GetPage(name: '/cart', page: () => CartScreen(),transition: Transition.downToUp),
            GetPage(name: '/buy', page: () => BuyProductScreen(),transition: Transition.downToUp),
          ],
        ),
      ),
    // )
  );
}