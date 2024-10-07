import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yardex_user/features/auth/presentation/providers/auth_provider.dart';
import 'package:yardex_user/shared/widgets/auth_text_field.dart';
import 'package:yardex_user/shared/widgets/primary_button.dart';

class ConfirmationScreen extends ConsumerStatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  ConsumerState<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends ConsumerState<ConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _confirmationCodeController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _confirmationCodeController.dispose();
    super.dispose();
  }

  void _confirmUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      final confirmationCode = _confirmationCodeController.text;

      try {
        await ref
            .read(authNotifierProvider.notifier)
            .confirmUser(username, confirmationCode);

        context.go('/home');
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Failed to confirm user.'),
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Account'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                AuthTextField(
                  controller: _confirmationCodeController,
                  labelText: 'Confirmation Code',
                  hintText: 'Enter your confirmation code',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirmation code';
                    }
                    return null;
                  },
                ),
                PrimaryButton(
                  onPressed: _confirmUser,
                  text: 'Confirm',
                ),
              ],
            ),
          ),
        ),
        if (isLoading) const Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
