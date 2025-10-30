import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:middle_exam/feature/home/data/model/user_model.dart';
import 'package:middle_exam/feature/home/domain/useCase/home_useCase.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._useCase)
    : super(HomeState(imageUrl: '', isUpdateSuccess: false, isUpdating: false, users: [], isDeleteSuccess: false));
  final HomeUseCase _useCase;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      emit(state.copyWith(imageUrl: image.path));
    } else {
      emit(state.copyWith(isUpdateSuccess: false));
    }
  }

  Future<void> addUser(UserModel user) async {
    emit(state.copyWith(isUpdating: true));
    final addUserIsSuccess = await _useCase.addNewUser(user);

    if (addUserIsSuccess) {
      final users = await _useCase.getUsers();
      emit(state.copyWith(isUpdateSuccess: true, users: users, isUpdating: false));
    } else {
      emit(state.copyWith(isUpdateSuccess: false, isUpdating: false));
    }
  }

  Future<void> deleteUser(String email) async {
    final deleteUserIsSuccess = await _useCase.deleteUser(email);

    if (deleteUserIsSuccess) {
      final users = await _useCase.getUsers();
      emit(state.copyWith(users: users, isDeleteSuccess: true));
    } else {
      emit(state.copyWith(isDeleteSuccess: false));
    }
  }

  Future<void> getUsers() async {
    final users = await _useCase.getUsers();
    emit(state.copyWith(users: users));
  }

  Future<void> removeImage() async {
    emit(state.copyWith(imageUrl: ''));
  }

  Future<void> signOut() async {
    final signOutIsSuccess = await _useCase.signOut();
  }

  Future<void> updateUser(UserModel user) async {
    final updateUserIsSuccess = await _useCase.updateUser(user);

    if (updateUserIsSuccess) {
      final users = await _useCase.getUsers();
      emit(state.copyWith(isUpdateSuccess: true, users: users, isUpdating: false));
    } else {
      emit(state.copyWith(isUpdateSuccess: false, isUpdating: false));
    }
  }
}
