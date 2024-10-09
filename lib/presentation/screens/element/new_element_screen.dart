import 'package:flutter/material.dart';

class NewElementScreen extends StatefulWidget {
  const NewElementScreen({super.key});
  static const String name = 'new_element_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewElementScreenState createState() => _NewElementScreenState();
}

class _NewElementScreenState extends State<NewElementScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Element'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name of new Element',
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
  runApp(const MaterialApp(home: NewElementScreen()));
}
