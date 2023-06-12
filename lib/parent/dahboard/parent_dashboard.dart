import 'package:flutter/material.dart';
import 'package:student_portal/admin/models/core/student_detail_model.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                getIt<AuthProvider>().logoutUser(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(children: [
        height10(),
        Text(
          "Children",
          style: mediumTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StudentDetailCard(
            model: StudentDetailModel(
                name: "Syed Saqib Hussain Shah",
                profilePhoto: null,
                program: "CS",
                regNo: "2019-Arid-3099",
                section: "A",
                semester: 3,
                session: "FALL2019"),
            trailing: const SizedBox.shrink(),
          ),
        )
      ]),
    );
  }
}
