import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/widgets/utils/snackbar.dart';
import 'package:track_shop_app/helper/notification_helper.dart';

class NewReminderDialog extends ConsumerStatefulWidget {
  static const String name = 'new_reminder_dialog';

  // Parámetro title que se pasa al constructor
  final String title;

  const NewReminderDialog({super.key, required this.title});

  @override
  _NewReminderDialogState createState() => _NewReminderDialogState();
}

class _NewReminderDialogState extends ConsumerState<NewReminderDialog> {
  final TextEditingController bodyController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Reminder',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Reminder Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text("Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                onTap: _selectDate,
              ),

              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text("Time: ${selectedTime.format(context)}"),
                onTap: _selectTime,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveReminder,
                    child: const Text('Set Reminder'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Seleccionar hora
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _saveReminder() async {
    if (bodyController.text.isEmpty) {
      SnackbarUtil.showSnackbar(
        context,
        'Please fill in the body.',
        backgroundColor: Colors.red,
      );
      return;
    }

    final DateTime reminderDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (reminderDateTime.isBefore(DateTime.now())) {
      SnackbarUtil.showSnackbar(
        context,
        'The reminder date must be in the future.',
        backgroundColor: Colors.red,
      );
      return;
    }

    await NotificationHelper.scheduledNotification(
      title: widget.title, // Usamos el título pasado como parámetro
      body: bodyController.text,
      scheduledDate: reminderDateTime,
    );

    // Guardar el recordatorio en la base de datos (puedes agregar los datos de warehouse/catalogue)
    // Aquí debes agregar la lógica para guardar el recordatorio en la base de datos de acuerdo a tu modelo

    // Después de guardar, puedes navegar a la pantalla correspondiente
    Navigator.of(context).pop();
  }
}
