import 'package:flutter/material.dart';
import 'package:flutter_survey_app_mobile/core/utils/size/border_radius/dynamic_border_radius.dart';

class CustomImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String placeholderImagePath;

  const CustomImageWidget({
    required this.imageUrl,
    required this.placeholderImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.borderRadiusTopMedium,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorIcon(context);
              },
            )
          : Image.asset(
              placeholderImagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorIcon(context);
              },
            ),
    );
  }

  Widget _buildErrorIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
