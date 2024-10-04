import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yardex_user/amplifyconfiguration.dart';
import 'package:yardex_user/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

Future<void> _configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    final apiPlugin = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, apiPlugin]);
    await Amplify.configure(amplifyconfig);
    print('Amplify configured successfully');
  } catch (e) {
    print('Error configuring Amplify: $e');
  }
}