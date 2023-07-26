import 'dart:convert';
import 'package:http/http.dart' as http;

// Replace 'YOUR_API_URL' with the actual URL of your API
const String apiUrl = 'https://directus-ienas.cloud.programmercepat.com/items/news';

Future<List<Map<String, dynamic>>> fetchData() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    // Assuming the "data" key contains the array of data
    final List<dynamic> dataList = jsonData['data'];
    return dataList.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data');
  }
}


