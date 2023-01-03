import 'dart:math';

import 'package:get/get.dart';
import 'package:wholesaler_user/app/constants/enum.dart';
import 'package:wholesaler_user/app/models/product_model.dart';
import 'package:wholesaler_user/app/models/user_model.dart';
import 'package:wholesaler_user/app/models/writable_review_info_model.dart';

class Review {
  int id;
  String content;
  String? reviewImageUrl;
  String? createdAt;
  String? writer;
  double rating;
  DateTime date;
  Product product;
  ProductRatingType ratingType;
  bool? isMine;
  List<String>? images;
  User? user;
  WritableReviewInfoModel? writableReviewInfoModel;

  Review({
    required this.id,
    required this.content,
    this.isMine,
    this.reviewImageUrl,
    required this.rating,
    required this.ratingType,
    required this.date,
    required this.product,
    this.images,
    this.createdAt,
    this.user,
    this.writableReviewInfoModel,
    this.writer,
  });
}
