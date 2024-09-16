import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomSheets {
  CustomSheets._();
  static Future<ImageSource?> showMenuForImage({
    required BuildContext context,
  }) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Kamera'),
              onTap: () {
                Navigator.pop(
                  context,
                  ImageSource.camera,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeri'),
              onTap: () {
                Navigator.pop(
                  context,
                  ImageSource.gallery,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
