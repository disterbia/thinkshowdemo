import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';
import 'package:wholesaler_user/app/constants/dimens.dart';
import 'package:wholesaler_user/app/constants/styles.dart';
import 'package:wholesaler_user/app/models/faq_page_model/faq_question.dart';
import 'package:wholesaler_user/app/models/faq_question_model.dart';

class FaqQuestionWidget extends StatelessWidget {
  final FaqQuestion questionItem;
  FaqQuestionWidget({required this.questionItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: MyColors.grey4), borderRadius: BorderRadius.all(Radius.circular(MyDimensions.radius))),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: _question(questionItem),
          children: [
            _answer(questionItem),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _answer(FaqQuestion item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Flexible(flex: 1, child: _answerMark()),
          Flexible(
            flex: 4,
            child: Text(
              item.answer!,
              style: MyTextStyles.f16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _question(FaqQuestion item) {
    return Row(
      children: [
        Flexible(flex: 1, child: _questionMark()),
        Flexible(
            flex: 4,
            child: Text(
              item.question!,
              style: MyTextStyles.f16,
            ))
      ],
    );
  }

  Widget _questionMark() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(color: MyColors.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              'Q',
              style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.black, backgroundColor: MyColors.primary),
            ),
          )),
    );
  }

  Widget _answerMark() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(color: MyColors.primary, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              'A',
              style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.white, backgroundColor: MyColors.primary),
            ),
          )),
    );
  }
}
