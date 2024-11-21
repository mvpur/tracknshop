import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/reminder.dart';
import 'package:track_shop_app/presentation/provider/reminder_provider.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_details.dart';

class ReminderScreen extends ConsumerStatefulWidget {
  static const String name = 'reminder_screen';

  const ReminderScreen({super.key});

  @override
  ConsumerState<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends ConsumerState<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    List<Reminder> reminders = ref.watch(reminderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: _ReminderListView(reminders: reminders),
    );
  }
}

class _ReminderListView extends StatelessWidget {
  final List<Reminder> reminders;

  const _ReminderListView({required this.reminders});

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return _ReminderListItem(reminder: reminder);
      },
    );
  }
}

class _ReminderListItem extends StatelessWidget {
  final Reminder reminder;

  const _ReminderListItem({required this.reminder});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminder.title),
      subtitle: Text(reminder.dateTimeToRemind.toString()),
      onTap: () {
        context.pushNamed(
          ReminderDetailScreen.name,
          pathParameters: {
            'reminderId': reminder.id,
          },
        );
      },
    );
  }
}
