// models/photo_model.dart
class PhotoModel {
  final String id; // Unique identifier for the photo
  final String thumbnailUrl; // URL for the thumbnail image
  final String fullImageUrl; // URL for the high-resolution image

  PhotoModel({
    required this.id,
    required this.thumbnailUrl,
    required this.fullImageUrl,
  });

  /// Factory constructor to create a PhotoModel instance from a JSON object
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as String,
      thumbnailUrl: json['urls']['small'] as String, // Small image for the grid
      fullImageUrl: json['urls']['full'] as String, // Full resolution image
    );
  }
}
