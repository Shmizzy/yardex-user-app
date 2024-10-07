import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex_user/features/auth/data/models/user_model.dart';
import 'package:yardex_user/shared/utils/validators.dart';
import 'package:yardex_user/shared/widgets/auth_text_field.dart';
import 'package:yardex_user/shared/widgets/primary_button.dart';
import 'package:yardex_user/features/auth/presentation/providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final isLoading = ref.read(authNotifierProvider);
      final newUser = UserModel(
        username: _usernameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
      );
      final password = _passwordController.text;

      try {
        await ref
            .read(authNotifierProvider.notifier)
            .register(newUser, password);
        print(isLoading);
        context.go('/confirm');
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Failed to register user.'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _cancel() {
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthTextField(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                AuthTextField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: _emailController,
                    validator: validateEmail),
                const SizedBox(height: 20.0),
                AuthTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  controller: _passwordController,
                  validator: validatePassword,
                ),
                const SizedBox(height: 20.0),
                AuthTextField(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                AuthTextField(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: _phoneNumberController,
                  validator: validatePhoneNumber,
                ),
                const SizedBox(height: 20.0),
                PrimaryButton(
                  text: 'Register',
                  onPressed: _register,
                ),
                const SizedBox(height: 10.0),
                TextButton(
                  onPressed: _cancel,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
