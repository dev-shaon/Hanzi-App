import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String urls;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? padding;
  final Widget? placeholder;

  const CustomNetworkImage({
    super.key,
    required this.urls,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedWidth = width ?? 70.w;
    final double resolvedHeight = height ?? 70.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: (urls.isEmpty || urls == 'null')
            ? (placeholder ??
                  _buildFallbackImage(resolvedWidth, resolvedHeight))
            : urls.startsWith('assets')
            ? Image.asset(
                urls,
                width: resolvedWidth,
                height: resolvedHeight,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    (placeholder ??
                    _buildFallbackImage(resolvedWidth, resolvedHeight)),
              )
            : !urls.startsWith('http')
            ? (placeholder ??
                  _buildFallbackImage(resolvedWidth, resolvedHeight))
            : CachedNetworkImage(
                imageUrl: urls,
                width: resolvedWidth,
                height: resolvedHeight,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: resolvedWidth,
                    height: resolvedHeight,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    (placeholder ??
                    _buildFallbackImage(resolvedWidth, resolvedHeight)),
              ),
      ),
    );
  }

  Widget _buildFallbackImage(double width, double height) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      color: Colors.grey[200],
      child: Icon(Icons.person, size: width * 0.6, color: Colors.grey[400]),
    );
  }
}
