/* import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yardex_user/features/auth/data/models/user_model.dart';
import 'package:yardex_user/features/auth/data/repositories/auth_repository.dart';

import '../../../../mocks/mock_auth_service.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authRepository = AuthRepository(authService: mockAuthService);
  });

  group('AuthRepository', () {
    final user = UserModel(
      username: 'testuser',
      email: 'test@example.com',
      phoneNumber: '+1234567890',
    );
    final password = 'password123';

    test('register should call AuthService.register', () async {
      when(mockAuthService.register(user, password))
          .thenAnswer((_) async => Future.value());

          await authRepository.register(user, password);

          verify(mockAuthService.register(user, password)).called(1);
    });

    test('register should throw an exception if AuthService.register fails', () async {
      when(mockAuthService.register(user, password))
          .thenThrow(Exception('Failed to register user'));

      expect(() => authRepository.register(user, password), throwsException);
    });
  });
}
 */