import 'package:middle_exam/feature/authentication/data/repository_impl/auth_repo_impl.dart';
import 'package:middle_exam/feature/authentication/domain/usecase/auth_usecase.dart';
import 'package:middle_exam/feature/authentication/presentation/cubit/auth_cubit.dart';

AuthCubit provideAuth() {
  final repo = AuthenticationRepoImpl();
  final useCase = AuthUseCase(repo);
  return AuthCubit(useCase);
}