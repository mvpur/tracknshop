import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_screen.dart';
import 'package:track_shop_app/presentation/screens/user/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const String name = 'settings_screen';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user is logged in.')),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              user.displayName ?? 'No Name Provided',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              user.email ?? 'No Email Provided',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Card(
            color: Colors.lightGreen.shade200,
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Reminders'),
              subtitle: const Text('See all your reminders!'),
              onTap: () {
                context.pushNamed(ReminderScreen.name);
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.red.shade200,
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              subtitle: const Text('Goodbye!'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                context.goNamed(LoginScreen.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
