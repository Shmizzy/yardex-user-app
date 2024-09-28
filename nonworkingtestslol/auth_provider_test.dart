/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yardex_user/features/auth/data/models/user_model.dart';
import 'package:yardex_user/features/auth/data/repositories/auth_repository.dart';
import 'package:yardex_user/features/auth/presentation/providers/auth_provider.dart';

import '../../../../mocks/mock_auth_service.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late AuthRepository authRepository;
  late AuthNotifier authNotifier;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepository(authService: mockAuthService);
    authNotifier = AuthNotifier()..authRepository = authRepository;
  });

  group('AuthNotifier', () {
    final user = UserModel(
      username: 'testuser',
      email: 'test@example.com',
      phoneNumber: '+1234567890',
    );
    final password = 'password123';

    test('register should set state to true while loading', () async {
      when(mockAuthService.register(user, password))
          .thenAnswer((_) async => Future.value());

      final container = ProviderContainer(overrides: [
        authNotifierProvider.overrideWith((ref) {
          final notifier = AuthNotifier();
          notifier.authRepository = authRepository;
          return notifier;
        } as AuthNotifier Function()),
      ]);

      expect(container.read(authNotifierProvider), false);

      final future = container.read(authNotifierProvider.notifier).register(user, password);

      expect(container.read(authNotifierProvider), true);

      await future;

      expect(container.read(authNotifierProvider), false);
    });


    test('register should call AuthRepository.register', () async {
      when(mockAuthService.register(user, password))
          .thenAnswer((_) async => Future.value());

      final container = ProviderContainer(overrides: [
        authNotifierProvider.overrideWith((ref) {
          final notifier = AuthNotifier();
          notifier.authRepository = authRepository;
          return notifier;
        } as AuthNotifier Function()),
      ]);

      await container.read(authNotifierProvider.notifier).register(user, password);

      verify(mockAuthService.register(user, password)).called(1);
    });

    test('register should thrown an exception if AuthRepository.register fails', () async {
      when(mockAuthService.register(user, password))
          .thenThrow(Exception('Failed to register user'));

      final container = ProviderContainer(overrides: [
        authNotifierProvider.overrideWith((ref) {
          final notifier = AuthNotifier();
          notifier.authRepository = authRepository;
          return notifier;
        } as AuthNotifier Function()),
      ]);

      expect(() => container.read(authNotifierProvider.notifier).register(user, password), throwsException);
    });

  });
}
 */