import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EditPage extends StatefulWidget {
  final DataModel data;

  const EditPage({super.key, required this.data});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.data.title);
    _descriptionController = TextEditingController(text: widget.data.description);
    _imageController = TextEditingController(text: widget.data.image);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _updateItem();
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateItem() {
    final String apiUrl = 'https://directus-ienas.cloud.programmercepat.com/items/news/${widget.data.id}';
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final String image = _imageController.text;

    // Prepare the updated data to send to the API
    final Map<String, dynamic> updatedData = {
      'title': title,
      'description': description,
      'image_url': image,
    };

    // Make the PUT request to update the item
    http.patch(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    ).then((response) {
      if (response.statusCode == 200) {
        print('Item updated successfully!');
        Navigator.pop(context, true); // Navigate back to the previous page and pass true to indicate success.
      } else {
        print('Error updating item: ${response.statusCode}');
        // You can show an error message to the user if needed.
      }
    }).catchError((e) {
      print('Error updating item: $e');
      // You can show an error message to the user if needed.
    });
  }
}
