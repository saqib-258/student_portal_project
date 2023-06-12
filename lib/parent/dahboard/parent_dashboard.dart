import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student_portal/admin/models/core/student_detail_model.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/parent/dahboard/parent_dashboard_detail.dart';
import 'package:student_portal/parent/model/children_model.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/shared/utils/common.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});
  Future<List<dynamic>> getMyChildren() async {
    String url =
        'http://$ip/StudentPortal/api/Parent/GetMyChildrens?username=${user.userDetail!.username}';
    Uri uri = Uri.parse(url);
    final response = await get(uri);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () {
                getIt<ChildrenModel>().clearRegNo();
                getIt<AuthProvider>().logoutUser(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          height10(),
          Text(
            "Children",
            style: mediumTextStyle,
          ),
          Expanded(
            child: FutureBuilder(
                future: getMyChildren(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          StudentDetailModel model =
                              StudentDetailModel.fromMap(snapshot.data![index]);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StudentDetailCard(
                              onTap: () {
                                getIt<ChildrenModel>().changeRegNo(model.regNo);
                                navigate(context,
                                    ParentDashboardDetail(name: model.name));
                              },
                              model: model,
                              trailing: const SizedBox.shrink(),
                            ),
                          );
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
          )
        ]),
      ),
    );
  }
}
