import '../../data/model/user_model.dart';

class HomeState {
  final String imageUrl;
  final bool isUpdateSuccess;
  final bool isDeleteSuccess;
  final bool isUpdating;
  final List<UserModel> users;

  HomeState({
    required this.imageUrl,
    required this.isUpdateSuccess,
    required this.isUpdating,
    required this.users,
    required this.isDeleteSuccess,
  });

  HomeState copyWith({
    String? imageUrl,
    bool? isUpdateSuccess,
    bool? isUpdating,
    List<UserModel>? users,
    bool? isDeleteSuccess,
  }) {
    return HomeState(
      imageUrl: imageUrl ?? this.imageUrl,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      isUpdating: isUpdating ?? this.isUpdating,
      users: users ?? this.users,
      isDeleteSuccess: isDeleteSuccess ?? this.isDeleteSuccess,
    );
  }

  HomeState isEmpty() {
    return HomeState(imageUrl: '', isUpdateSuccess: true, isUpdating: false, users: [], isDeleteSuccess: false);
  }
}
