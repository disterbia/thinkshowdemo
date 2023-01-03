class FaqQuestion {
  int? faqId;
  String? question;
  String? answer;

  FaqQuestion({this.faqId, this.question, this.answer});

  factory FaqQuestion.fromJson(Map<String, dynamic> json) => FaqQuestion(
        faqId: json['faq_id'] as int?,
        question: json['question'] as String?,
        answer: json['answer'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'faq_id': faqId,
        'question': question,
        'answer': answer,
      };
}
