import 'package:flutter/material.dart';

class ImageDetailView extends StatelessWidget {
  const ImageDetailView({
    required this.photoUrl,
    super.key,
  });

  final String photoUrl;

  /// Downloads the image to the device and shows a toast message


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: photoUrl, // Matches the tag used in HomeView for Hero animation
              child: Image.network(
                photoUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
