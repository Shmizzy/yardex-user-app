import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yardex_user/config/config.dart';
import 'package:yardex_user/core/errors/exceptions.dart';
import 'package:yardex_user/features/auth/data/models/user_model.dart';
import 'package:yardex_user/features/auth/data/repositories/auth_repository.dart';
import 'package:yardex_user/features/auth/data/services/auth_service.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository authRepository;

  @override
  bool build() {
    final authService = AuthService(baseUrl: Config.apiBaseUrl);
    authRepository = AuthRepository(authService: authService);

    return false;
  }

  Future<void> register(UserModel user, String password) async {
    state = true;

    try {
      await authRepository.register(user, password);
    } on ValidationException catch (e) {
      print(e.message);
    } on AuthException catch (e) {
      print(e.message);
    } on ServerException catch (e) {
      print(e.message);
    } on NetworkException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    } finally {
      state = false;
    }
  }
}
