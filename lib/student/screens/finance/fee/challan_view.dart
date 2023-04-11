import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/services/fee_api.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ChallanView extends StatefulWidget {
  const ChallanView({super.key, required this.challanUrl});
  final String challanUrl;

  @override
  State<ChallanView> createState() => _ChallanViewState();
}

class _ChallanViewState extends State<ChallanView> {
  // static Future<void> openFile(String filePath) async {
  //   await OpenFilex.open(filePath);
  // }

  // static Future<void> callback(
  //     String id, DownloadTaskStatus status, int progress) async {}

  // Future<void> requestDownload(String url, String name) async {
  //   Directory dir = Directory('/storage/emulated/0/Download');
  //   var localPath = dir.path;
  //   final savedDir = Directory(localPath);
  //   String fullPath;
  //   await savedDir.create(recursive: true).then((value) async {
  //     fullPath = '$localPath/$name';
  //     int fileNumber = 0;
  //     while (await File(fullPath).exists()) {
  //       fileNumber++;
  //       fullPath = '$localPath/${name.replaceAll('.', '($fileNumber).')}';
  //     }
  //     await FlutterDownloader.enqueue(
  //       url: url,
  //       fileName: fullPath.split('/').last,
  //       savedDir: localPath,
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //   });
  // }

  @override
  void initState() {
    // FlutterDownloader.registerCallback(callback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text("Challan View"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SfPdfViewer.network(
                    "http://$ip/StudentPortal/ChallanFiles/${widget.challanUrl}",
                    scrollDirection: PdfScrollDirection.horizontal,
                    canShowScrollHead: false,
                  ),
                ),
              ),
              height10(),
              AppButton(
                  child: Text(
                    "Download",
                    style: textColorStyle,
                  ),
                  onTap: () async {
                    await FeeApi().downloadFile(
                        "http://$ip/StudentPortal/ChallanFiles/${widget.challanUrl}",
                        "challan.pdf");
                    // requestDownload(
                    //     "http://$ip/StudentPortal/ChallanFiles/${widget.challanUrl}",
                    //     "challan.pdf");
                  }),
            ],
          ),
        ));
  }
}
