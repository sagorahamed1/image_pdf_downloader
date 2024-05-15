import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image & PDF Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class Item {
  final String name;
  final String url;
  final String type;
  final String size;

  Item({required this.name, required this.url, required this.type, required this.size});
}



class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "name": "Document1",
      "url": "http://example.com/document1.pdf",
      "type": "pdf",
      "size": "2.5MB"
    },
    {
      "name": "Image1",
      "url": "http://example.com/image1.jpg",
      "type": "image",
      "size": "1.3MB"
    },
    {
      "name": "Document2",
      "url": "http://example.com/document2.pdf",
      "type": "pdf",
      "size": "3.8MB"
    },
    {
      "name": "Image2",
      "url": "http://example.com/image2.jpg",
      "type": "image",
      "size": "0.9MB"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          if (item['type'] == 'pdf') {
            return GestureDetector(
              onTap: () {
                // Handle PDF item tap
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.picture_as_pdf, size: 50),
                    Text(item['name']),
                    Text('Size: ${item['size']}'),
                  ],
                ),
              ),
            );
          } else if (item['type'] == 'image') {
            return GestureDetector(
              onTap: () {
                // Handle image item tap
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      item['url'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(item['name']),
                    Text('Size: ${item['size']}'),
                  ],
                ),
              ),
            );
          } else {
            return Container(); // Placeholder for other types of items
          }
        },
      ),
    );
  }
}