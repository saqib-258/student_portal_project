import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/shared/utils/grid_view_items.dart';

class ParentDashboardDetail extends StatelessWidget {
  const ParentDashboardDetail({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            itemCount: parentDashboarGridItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              GridItem item = parentDashboarGridItems[index];
              return GestureDetector(
                onTap: () {
                  navigate(context, item.screen);
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.image,
                        height: 56,
                        width: 56,
                      ),
                      height20(),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: header3TextStyle,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
