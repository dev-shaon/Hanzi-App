import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  final bool isLocal;
  const FullScreenImage({super.key, required this.url, required this.isLocal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: isLocal
              ? Image.file(File(url))
              : CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  placeholder: (_, _) => const CircularProgressIndicator(),
                  errorWidget: (_, _, _) =>
                      const Icon(Icons.broken_image, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
