import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> furnitureList = [
    {
      'image': 'assets/images/chair.png', 'model': 'chair.glb', 'plane': 'horizontal',
    },
    {
      'image': 'assets/images/shelf.png', 'model': 'shelf.glb', 'plane': 'horizontal',
    },
    {
      'image': 'assets/images/sofa.png', 'model': 'sofa.glb', 'plane': 'horizontal',
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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/ar',
                  arguments: furnitureList[index],
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          furnitureList[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        furnitureList[index]['model']!.replaceAll('.glb', ''),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
}
}
