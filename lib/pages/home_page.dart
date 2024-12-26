import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> furnitureList = [
    {
      'image': 'assets/images/chair.png', 'model': 'assets/models/chair.obj'
    },
    {
      'image': 'assets/images/chair2.png', 'model': 'assets/models/chair2.obj'
    },
    {
      'image': 'assets/images/chair3.png', 'model': 'assets/models/chair3.obj'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         forceMaterialTransparency: true,
         title: Text('Choose furniture'),
         centerTitle: true,
       ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: furnitureList.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/ar',
                  arguments: furnitureList[index]['model'],
                );
              },
              child: Container(
                child: Text('${furnitureList[index]['model']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
