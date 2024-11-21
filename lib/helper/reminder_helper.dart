import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:track_shop_app/core/router/app_router.dart';
import 'package:track_shop_app/entities/reminder.dart';

class ReminderHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        final payload = notificationResponse.payload;
        await onSelectNotification(payload);
      },
    );


    tz.initializeTimeZones();
  }

  static Future<Reminder> scheduledNotification( {
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'important_notifications',
      'Reminder Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    final tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(scheduledDate, tz.local);

    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _notification.zonedSchedule(
      id,
      title,
      body,
      scheduledTZDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: id.toString(), );

    return  Reminder(id: id.toString(), title: title, description: body, dateTimeToRemind: scheduledDate);

  }

  static Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      final reminderId = payload;
      appRouter.pushNamed(
        'reminder_detail_screen',
        pathParameters: {'reminderId': reminderId},
      );
    }
  }

  static Future<void> cancelNotification(Reminder reminder) async {
    await _notification.cancel(int.parse(reminder.id));
  }

  static Future<void> cancelAllNotifications(List<Reminder> reminders) async {
    for (Reminder reminder in reminders){
      await _notification.cancel(int.parse(reminder.id));
    }
  }
}
