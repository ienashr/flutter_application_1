
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'data_model.dart';
import 'data_form_page.dart';
import 'package:http/http.dart' as http;
import 'edit_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ... The code for the FutureBuilder and UI goes here ...
      return Scaffold(
      appBar: AppBar(title: const Text('API Data')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final data = DataModel.fromJson(snapshot.data![index]);

                // Apply consistent styles using a Card with a Column
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        data.image,
                        height: 150, // Adjust the image height as needed
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(data.description),

                          ],
                        ),

                      ), IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to the edit page with the data for editing
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(data: data),
                ),
              ).then((success) {
                // After editing, refresh the data if the edit was successful.
                if (success == true) {
                  fetchData(); // Call the fetch data method again to refresh the data.
                }
              });
            },
          ),
                      
                      IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Call the API to delete the item
                        _deleteItem(data.id); // Implement this method to delete the item
                      },
                    ),

                    ],
                  ),
                );
              },
            );
          }
        }, 
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When the user taps the FloatingActionButton, navigate to the DataFormPage
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DataFormPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

 void _deleteItem(int id) async {
    const String apiUrl = 'https://directus-ienas.cloud.programmercepat.com/items/news';

    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        print('Item deleted successfully!');
      } else {
        print('Error deleting item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

