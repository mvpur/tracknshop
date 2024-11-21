import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_shop_app/entities/reminder.dart';

class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final Function? onTap;
  final Color backgroundColor;

  const ReminderCard({
    super.key,
    required this.reminder,
    this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm').format(reminder.dateTimeToRemind);

    return Card(
      color: backgroundColor,
      child: ListTile(
        leading: const Icon(Icons.notifications),
        title: Text(reminder.title),
        subtitle: Text('Reminder: $formattedDate'),
        onTap: () => onTap?.call(),
      ),
    );
  }
}
