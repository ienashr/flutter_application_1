import 'package:flutter/material.dart';
import 'api_service.dart';
import 'data_model.dart';
import 'data_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ... The code for the FutureBuilder and UI goes here ...
      return Scaffold(
      appBar: AppBar(title: Text('API Data')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                  margin: EdgeInsets.all(8),
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text(data.description),
                          ],
                        ),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => DataFormPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
