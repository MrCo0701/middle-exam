import 'package:middle_exam/feature/authentication/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<bool> signInWithGoogle() async {
    try {
      return await repository.signInWithGoogle();
    } catch (e) {
      Exception('==> Error for signInWithGoogle: $e');
      return false;
    }
  }
}