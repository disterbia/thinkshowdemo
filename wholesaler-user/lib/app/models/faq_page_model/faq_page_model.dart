import 'faq_question.dart';

class FaqPageModel {
  int? faqCategoryId;
  String? faqCategoryName;
  List<FaqQuestion>? questions;

  FaqPageModel({this.faqCategoryId, this.faqCategoryName, this.questions});

  factory FaqPageModel.fromJson(Map<String, dynamic> json) => FaqPageModel(
        faqCategoryId: json['faq_category_id'] as int?,
        faqCategoryName: json['faq_category_name'] as String?,
        questions: (json['questions'] as List<dynamic>?)?.map((e) => FaqQuestion.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'faq_category_id': faqCategoryId,
        'faq_category_name': faqCategoryName,
        'questions': questions?.map((e) => e.toJson()).toList(),
      };
}
