import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/providers/fine_provider.dart';

class FineScreen extends StatefulWidget {
  const FineScreen({super.key});

  @override
  State<FineScreen> createState() => _FineScreenState();
}

class _FineScreenState extends State<FineScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<FineProvider>().getFineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fine"),
      ),
      body: Consumer<FineProvider>(builder: (context, provider, _) {
        if (provider.fList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.fList!.isEmpty) {
          return const Center(
            child: Text("No fine yet"),
          );
        }
        return ListView.builder(
            itemCount: provider.fList!.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Column(
                children: [
                  Text(
                    provider.fList![index].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ));
            });
      }),
    );
  }
}
