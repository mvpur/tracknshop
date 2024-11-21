import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
    );
    tz.initializeTimeZones();
  }

  static Future<void> scheduledNotification( {
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
    );
  }
}
