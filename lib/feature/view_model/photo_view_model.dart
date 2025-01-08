import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:walpapper_task_app/feature/model/photo_model.dart';
import 'package:walpapper_task_app/feature/services/photo_api.dart';

class PhotoViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<PhotoModel> photos = [];
  bool isLoading = false;
  int currentPage = 1;

  Future<void> fetchPhotos({required bool reset}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      if (reset) {
        photos.clear();
        currentPage = 1;
      }

      final newPhotos = await _apiService.fetchPhotos(page: currentPage);
      photos.addAll(newPhotos);
      currentPage++;
      log(newPhotos.toString());
    } catch (e) {
      log('Error fetching photos: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> downloadImage(BuildContext context, String imageUrl) async {
    try {
      isLoading = true;
      notifyListeners();

      final dio = Dio();
      final directory = await getApplicationDocumentsDirectory();

      final filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await dio.download(imageUrl, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image downloaded to: $filePath'),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download image: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
