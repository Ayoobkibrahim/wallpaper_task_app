
import 'package:flutter/material.dart';
import 'package:walpapper_task_app/feature/model/photo_model.dart';
import 'package:walpapper_task_app/feature/services/photo_api.dart';


class PhotoViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<PhotoModel> photos = [];
  bool isLoading = false;
  int currentPage = 1;

  Future<void> fetchPhotos() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final newPhotos = await _apiService.fetchPhotos(page: currentPage);
      photos.addAll(newPhotos);
      currentPage++;
    } catch (e) {
      // print('Error fetching photos: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
