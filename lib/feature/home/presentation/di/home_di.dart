import '../../data/repository_impl/home_repo_impl.dart';
import '../../domain/useCase/home_useCase.dart';
import '../cubit/home_cubit.dart';

HomeCubit provideHomeCubit() {
  final repo = HomeRepositoryImpl();
  final useCase = HomeUseCase(repo);
  return HomeCubit(useCase);
}
