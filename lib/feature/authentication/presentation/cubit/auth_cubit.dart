import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:middle_exam/feature/authentication/domain/usecase/auth_usecase.dart';
import 'package:middle_exam/feature/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._useCase) : super(AuthInitial());
  final AuthUseCase _useCase;

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final check = await _useCase.signInWithGoogle();
      if (check) {
        emit(AuthSuccess());
      } else {
        emit(AuthError('Error for signInWithGoogle'));
      }
    } catch (e) {
      emit(AuthError('==> Error for signInWithGoogle: $e'));
    }
  }
}
