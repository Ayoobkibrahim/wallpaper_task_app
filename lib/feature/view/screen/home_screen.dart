import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walpapper_task_app/feature/view/widgets/image_detail_view.dart';
import 'package:walpapper_task_app/feature/view_model/photo_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final photoViewModel = Provider.of<PhotoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper App'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !photoViewModel.isLoading) {
            photoViewModel.fetchPhotos();
          }
          return true;
        },
        child: photoViewModel.photos.isEmpty && photoViewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: photoViewModel.photos.length,
                itemBuilder: (context, index) {
                  final photo = photoViewModel.photos[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImageDetailView(photoUrl: photo.fullImageUrl),
                      ),
                    ),
                    child: Hero(
                      tag: photo.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          photo.thumbnailUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}