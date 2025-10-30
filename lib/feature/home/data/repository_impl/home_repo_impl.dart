import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:middle_exam/feature/home/data/model/user_model.dart';
import 'package:middle_exam/feature/home/domain/repository/home_repository.dart';
import 'package:http/http.dart' as http;

class HomeRepositoryImpl implements HomeRepository {
  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> addNewUser(UserModel user) async {
    try {
      const cloudName = 'duqdmfqie';
      const uploadPreset = 'middle_exam_preset';

      final uploadUrl = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      final request = http.MultipartRequest('POST', uploadUrl)
        ..fields['upload_preset'] = uploadPreset
        ..fields['folder'] = 'middle_exam'
        ..files.add(await http.MultipartFile.fromPath('file', user.imageUrl));

      final response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = jsonDecode(res.body);
        user = user.copyWith(imageUrl: data['secure_url']);

        await firebaseFirestore.collection('Users').doc(user.email).set(user.toJson());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('==> Error to add User: $e');
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final snapShot = await firebaseFirestore.collection('Users').get();
      final users = snapShot.docs.map((e) => UserModel.fromJson(e.data())).toList();
      return users;
    } catch (e) {
      throw Exception('==> Error to get Users: $e');
    }
  }

  @override
  Future<bool> removeUser(String email) async {
    try {
      await firebaseFirestore.collection("Users").doc(email).delete();
      return true;
    } catch (e) {
      return false;
      // throw Exception('==> Error to remove User: $e');
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      await firebaseFirestore.collection('Users').doc(user.email).update(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
