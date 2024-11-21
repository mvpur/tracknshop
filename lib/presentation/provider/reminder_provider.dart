import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';

import '../../entities/reminder.dart';

final reminderProvider =
StateNotifierProvider<ReminderProvider, List<Reminder>>(
      (ref)  {
    final userNotifier = ref.read(userProvider.notifier);
    return ReminderProvider(userNotifier);
  },
);


class ReminderProvider extends StateNotifier<List<Reminder>> {
  final UserNotifier userNotifier;
  static const String collection = 'reminder';
  ReminderProvider(this.userNotifier) : super([]) {
    _listenToReminders();
  }

  Future<void> _listenToReminders() async {
    final userReference = await userNotifier.getDocumentReference();
    userReference
        .collection(collection).where('dateTimeToRemind',isGreaterThan: DateTime.now() )
        .orderBy('dateTimeToRemind', descending: true)
        .withConverter(
      fromFirestore: Reminder.fromFirestore,
      toFirestore: (Reminder reminder, _) => reminder.toFirestore(),
    )
        .snapshots()
        .listen((snapshot) {
      final reminders = snapshot.docs.map((doc) => doc.data()).toList();

      state = reminders;
    });
  }

  Future<Reminder> getReminder(String reminderId) async {
    final userReference = await userNotifier.getDocumentReference();

    try {
      final doc = await userReference.collection(collection).doc(reminderId).get();
      if (doc.exists) {
        return Reminder.fromFirestore(doc, null);
      } else {
        throw Exception('Reminder not found');
      }
    } catch (e) {
      print('Error fetching reminder: $e');
      rethrow;
    }
  }

  Future<void> addReminder(Reminder reminder) async {
    final userReference = await userNotifier.getDocumentReference();
    final doc = userReference.collection(collection).doc(reminder.id);
    try {
      await doc.set(reminder.toFirestore());
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteReminder(String id) async {
    final userReference = await userNotifier.getDocumentReference();
    try {
      await userReference.collection(collection).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
