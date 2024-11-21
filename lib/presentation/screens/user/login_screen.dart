import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/provider/user_provider.dart';
import 'package:track_shop_app/presentation/screens/user/register_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:track_shop_app/presentation/widgets/utils/snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final userProviderNotifier = ref.read(userProvider.notifier);

                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    SnackbarUtil.showSnackbar(
                      context,
                      'Please fill in all fields.',
                      backgroundColor: Colors.red,
                    );
                    return;
                  }

                  try {
                    final user = await userProviderNotifier.login(
                      emailController.text,
                      passwordController.text,
                    );

                    if (user != null) {
                      context.goNamed(WarehouseScreen.name);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      SnackbarUtil.showSnackbar(
                        context,
                        'No user found for that email.',
                        backgroundColor: Colors.red,
                      );
                    } else if (e.code == 'wrong-password') {
                      SnackbarUtil.showSnackbar(
                        context,
                        'Incorrect password. Please try again.',
                        backgroundColor: Colors.red,
                      );
                    } else {
                      SnackbarUtil.showSnackbar(
                        context,
                        'An error occurred. Please try again later.',
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.goNamed(RegisterScreen.name);
                },
                child: const Text('Create new account!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
