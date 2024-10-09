import 'package:flutter/material.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});
  static const String name = 'new_category_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name of new Category',
                hintText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: NewCategoryScreen()));
}
