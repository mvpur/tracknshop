import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/core/router/app_router.dart';
import 'package:track_shop_app/firebase_options.dart';
import 'package:track_shop_app/helper/notification_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  NotificationHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
    );
  }
}
