import 'package:cached_network_image/cached_network_image.dart';
import 'package:catchit/core/utils/consts/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class NetworkImageFadeWidget extends StatelessWidget {
  const NetworkImageFadeWidget({
    Key? key,
    required this.width,
    required this.imageUrl,
    required this.radius,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  final double? width;
  final double? height;
  final String? imageUrl;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: ColoredBox(
        color: ThemeConstants.blackGray,
        child: SizedBox(
          width: width,
          height: height,
          child: imageUrl == null || imageUrl == ''
              ? null
              : OctoImage(
                  image: CachedNetworkImageProvider(imageUrl!),
                  placeholderBuilder:
                      OctoPlaceholder.blurHash('L03baqj]fQj]oMfQfQfQfQfQfQfQ'),
                  errorBuilder: OctoError.icon(icon: Icons.wifi_off_rounded),
                  fit: fit,
                ),
        ),
      ),
    );
  }
}
