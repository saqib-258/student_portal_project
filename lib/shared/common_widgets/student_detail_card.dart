import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/photo_viewer_screen.dart';
import 'package:student_portal/shared/utils/common.dart';

class StudentDetailCard extends StatelessWidget {
  const StudentDetailCard(
      {super.key, required this.model, required this.trailing, this.onTap});

  final dynamic model;
  final VoidCallback? onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.profilePhoto == null
                        ? const CircleAvatar(
                            radius: 24,
                            backgroundColor: primaryColor,
                            backgroundImage:
                                AssetImage("assets/images/avatar-icon.png"),
                          )
                        : GestureDetector(
                            onTap: () {
                              navigate(
                                  context,
                                  PhotoViewerScreen(
                                      photo: getFileUrl("ProfileImages",
                                          model.profilePhoto!)));
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: primaryColor,
                              backgroundImage: NetworkImage(getFileUrl(
                                  "ProfileImages", model.profilePhoto!)),
                            ),
                          ),
                    width10(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(model.regNo),
                          Text(
                              'BS${model.program}-${model.semester}${model.section}')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              trailing
            ],
          ),
        ),
      ),
    );
  }
}
