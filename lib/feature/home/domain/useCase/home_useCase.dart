import '../../data/model/user_model.dart';
import '../repository/home_repository.dart';

class HomeUseCase {
  final HomeRepository _repository;

  HomeUseCase(this._repository);

  Future<bool> addNewUser(UserModel user) async {
    try {
      return await _repository.addNewUser(user);
    } catch (e) {
      throw Exception('==> BUG for addNewUser: $e');
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      return await _repository.getUsers();
    } catch (e) {
      throw Exception('==> BUG for getUsers: $e');
    }
  }

  Future<bool> deleteUser(String email) async {
    try {
      return await _repository.removeUser(email);
    } catch (e) {
      throw Exception('==> BUG for deleteUser: $e');
    }
  }

  Future<bool> signOut() async {
    try {
      return await _repository.signOut();
    } catch (e) {
      throw Exception('==> BUG for signOut: $e');
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      return await _repository.updateUser(user);
    } catch (e) {
      throw Exception('==> BUG for updateUser: $e');
    }
  }
}
