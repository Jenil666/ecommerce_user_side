import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_side/utils/fire_base_helper.dart';
import 'package:get/get.dart';

class BuyScreenController extends GetxController
{
  RxList data = [].obs;
  List dataarray = [];
  Future<void> getBuyDataOfUser()
  async {
    QuerySnapshot? querySnapshort = await FireBaseHelper.fireBaseHelper.readBuyData();
    var map = querySnapshort.docs;
    dataarray.clear();
    for(int i =0;i<map.length;i++ )
      {
        dataarray.add(map[i]['products']);
      }
    data.clear();
    for(int i =0;i<dataarray.length;i++ )
      {
        data.add(dataarray[i]);
      }
    print("================================== data");
    print(data);
  }
}