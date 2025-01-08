import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:walpapper_task_app/feature/model/photo_model.dart';


class ApiService {
  static const String baseUrl = 'https://api.unsplash.com';
  static const String apiKey = 'h8lAIGeYGFXcJTBpDHsMcqPigUW5b2JUma1Ejd89Ivk'; 

  Future<List<PhotoModel>> fetchPhotos({int page = 1, int perPage = 20}) async {
    final url = Uri.parse('$baseUrl/photos?page=$page&per_page=$perPage');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Client-ID $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      log(data.toString());
      return data.map((json) => PhotoModel.fromMap(json)).toList();
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load photos');
    }
  }

}
