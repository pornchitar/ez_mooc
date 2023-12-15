import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/like_vdo_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LikeVdoView(),
    );
  }
}

class LikeVdoView extends StatelessWidget {
  LikeVdoView({Key? key}) : super(key: key);

  // Updated dummy data with three video cards
  final List<Map<String, dynamic>> videoList = [
    {
      'image': 'images/gost.png',
      'title': 'สิ่งจริงหรือ???',
      'author': 'Mr.โกย',
      'progress': 0.44,
    },
    {
      'image': 'images/fantasy.png',
      'title': 'ตำนานสุดแสน',
      'author': 'Ms.แฟนตาซี',
      'progress': 0.75,
    },
    {
      'image': 'images/adventure.png',
      'title': 'การผจญภัยที่ไม่มีวันลืม',
      'author': 'นักผจญภัย',
      'progress': 0.60,
    },
    {
      'image': 'images/adventure.png',
      'title': 'การผจญภัยที่ไม่มีวันลืม',
      'author': 'นักผจญภัย',
      'progress': 0.60,
    },
    // You can add more items if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการที่ถูกใจ'),
        leading: Icon(Icons.arrow_back),
        actions: [Icon(Icons.settings)],
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final item = videoList[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(item['image']), // Video thumbnail
                  title: Text(item['title']),
                  subtitle: Text(item['author']),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      // Handle more button press
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(
                    value: item['progress'], // Current progress
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
