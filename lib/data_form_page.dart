import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class DataFormPage extends StatefulWidget {
  const DataFormPage({super.key});

  @override
  _DataFormPageState createState() => _DataFormPageState();
}

class _DataFormPageState extends State<DataFormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(); // New controller for image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // You can handle form submission here
                _submitData();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Add a method to handle form submission
Future<void> _submitData() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String imageUrl = _imageController.text;

    // Define the API endpoint URL
    const String apiUrl = 'https://directus-ienas.cloud.programmercepat.com/items/news';

    // Create a Map to hold the form data
    final Map<String, dynamic> formData = {
      'title': title,
      'description': description,
      'image_url': imageUrl,
    };

    try {
      // Make the POST request to the API endpoint
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData), // Encode the data as JSON
      );

      if (response.statusCode == 200) {
        // Data successfully sent to the server
        print('Data sent successfully!');
        Navigator.pop(context); // Go back to the previous page (main page) after successful submission.
      } else {
        // Handle any errors or bad responses from the server
        print('Error: ${response.statusCode}, ${response.body}');
        // You can show an error message to the user if needed.
      }
    } catch (e) {
      // Handle any exceptions or network errors
      print('Error: $e');
      // You can show an error message to the user if needed.
    }
  }
}