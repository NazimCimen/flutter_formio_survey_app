import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/config/localization/string_constants.dart';
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
              title: Text(StringConstants.camera),
              onTap: () {
                Navigator.pop(
                  context,
                  ImageSource.camera,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: Text(StringConstants.gallery),
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
