class InquiriesPageModel {
  int? id;
  String? content;
  dynamic answerContent;
  bool? isAnswer;
  bool? isSecret;
  String? createdAt;

  InquiriesPageModel({
    this.id,
    this.content,
    this.answerContent,
    this.isAnswer,
    this.isSecret,
    this.createdAt,
  });

  factory InquiriesPageModel.fromJson(Map<String, dynamic> json) {
    return InquiriesPageModel(
      id: json['id'] as int?,
      content: json['content'] as String?,
      answerContent: json['answer_content'] as dynamic,
      isAnswer: json['is_answer'] as bool?,
      isSecret: json['is_secret'] as bool?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'answer_content': answerContent,
        'is_answer': isAnswer,
        'is_secret': isSecret,
        'created_at': createdAt,
      };
}
