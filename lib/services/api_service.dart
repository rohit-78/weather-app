import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> fetchClimateData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body.split('\n').skip(6).toList(); // Skip metadata
    } else {
      throw Exception('Failed to load data');
    }
  }
}
