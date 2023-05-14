import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';

class ContestSetting extends StatelessWidget {
  const ContestSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contest Setting"),
      ),
      body: Column(
        children: [
          height20(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              "Days",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    )),
                Text(
                  "4",
                  style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      size: 30,
                    )),
              ],
            )
          ]),
          height30(),
          ElevatedButton(onPressed: () {}, child: Text("Save"))
        ],
      ),
    );
  }
}
