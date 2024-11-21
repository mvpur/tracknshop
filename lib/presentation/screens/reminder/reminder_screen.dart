import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/core/data/colors_datasourse.dart';
import 'package:track_shop_app/entities/reminder.dart';
import 'package:track_shop_app/presentation/provider/reminder_provider.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_details.dart';
import 'package:track_shop_app/presentation/widgets/cards/reminder_card.dart';

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

  Color getColor(int index, BuildContext context) {
    final List<Color> colors = List.from(colorsList);
    colors.shuffle();
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        final itemColor = getColor(index, context);
        return ReminderCard(
          reminder: reminder,
          onTap: () => _goToReminderDetails(context, reminder),
          backgroundColor: itemColor,
        );
      },
    );
  }

  void _goToReminderDetails(BuildContext context, Reminder reminder) {
    context.pushNamed(
      ReminderDetailScreen.name,
      pathParameters: {
        'reminderId': reminder.id,
      },
    );
  }
}
