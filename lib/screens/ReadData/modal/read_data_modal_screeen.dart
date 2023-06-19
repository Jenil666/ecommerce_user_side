import 'package:get/get.dart';

class HotSalesModal extends GetxController {
  String? category,
      price,
      name,
      description,
      company,
      discount,
      quantity,
      id,
      discountedPrice,
      image,
      review,
      totalReview;

  HotSalesModal(
      {this.category,
      this.price,
      this.name,
      this.description,
      this.company,
      this.discount,
      this.quantity,
      this.id,
      this.discountedPrice,
      this.image,
      this.review,
      this.totalReview});
}
