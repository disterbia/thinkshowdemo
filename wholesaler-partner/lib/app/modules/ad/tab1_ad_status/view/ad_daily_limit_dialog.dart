import 'package:flutter/material.dart';
import 'package:get/get.dart';

AdDailyDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        height: 291,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('잔여 포인트'),
                SizedBox(width: 20),
                Text(
                  '900,000P',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('daily_budget'.tr),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('원'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text('When_the_daily_budge'.tr),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('cancel'.tr),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Ad_registration'.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
