import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: SizedBox(
        height: 25.0,
        width: 25.0,
        child: CircularProgressIndicator(
          value: null,
        ),
      )),
    );
  }
}
