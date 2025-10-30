import 'package:middle_exam/feature/home/data/model/user_model.dart';

abstract class HomeRepository {
  Future<bool> addNewUser(UserModel user);
  Future<List<UserModel>> getUsers();
  Future<bool> removeUser(String email);
  Future<bool> signOut();
  Future<bool> updateUser (UserModel user);
}