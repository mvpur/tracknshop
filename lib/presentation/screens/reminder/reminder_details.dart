import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/core/router/app_router.dart';
import 'package:track_shop_app/entities/reminder.dart';
import 'package:track_shop_app/presentation/provider/reminder_provider.dart';
import 'package:track_shop_app/presentation/screens/reminder/new_reminder_dialog.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';

class ReminderDetailScreen extends ConsumerStatefulWidget {
  static const String name = 'reminder_detail_screen';
  final String reminderId;

  const ReminderDetailScreen({required this.reminderId, Key? key}) : super(key: key);

  @override
  _ReminderDetailScreenState createState() => _ReminderDetailScreenState();
}

class _ReminderDetailScreenState extends ConsumerState<ReminderDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Details'),
      ),
      body: FutureBuilder<Reminder?>(
        future: ref.read(reminderProvider.notifier).getReminder(widget.reminderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el recordatorio: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró el recordatorio'));
          } else {
            final reminder = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    reminder.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Date:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    reminder.dateTimeToRemind.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await deleteReminder(widget.reminderId);
                          context.goNamed(ReminderScreen.name);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Delete', style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: ()async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return NewReminderDialog(title: reminder.title,
                                    description: reminder.description);
                              }
                          );
                          context.goNamed(ReminderScreen.name);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text('Remind again', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> deleteReminder(String reminderId) async {
    try {
      await ref.read(reminderProvider.notifier).deleteReminder(reminderId);
    } catch (e) {
      print('Error deleting reminder: $e');
    }
  }
}
