import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpapper_task_app/feature/view_model/photo_view_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.likes,
  });

  final String imageUrl;
  final String title;
  final int likes;

  @override
  Widget build(BuildContext context) {
    final photoViewModel = Provider.of<PhotoViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () => photoViewModel.downloadImage(context, imageUrl),
      child: Container(
        margin: const EdgeInsets.all(4), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.black),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(
                  Icons.more_horiz,
                )
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
