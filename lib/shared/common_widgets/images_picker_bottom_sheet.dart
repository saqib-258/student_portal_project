import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const ImagePickerBottomSheet(
      {super.key, required this.onImageSourceSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  onImageSourceSelected(ImageSource.gallery);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(
                        flex: 3,
                      ),
                      Expanded(flex: 2, child: Icon(Icons.image)),
                      Expanded(flex: 2, child: Text('Gallery')),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  onImageSourceSelected(ImageSource.camera);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Spacer(
                        flex: 3,
                      ),
                      Expanded(flex: 2, child: Icon(Icons.camera_alt)),
                      Expanded(flex: 2, child: Text('Camera')),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
