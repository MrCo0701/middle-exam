class UserModel {
  final String email;
  final String userName;
  final String password;
  final String imageUrl;

  UserModel({
    required this.email,
    required this.userName,
    required this.password,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      userName: json['userName'],
      password: json['password'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'userName': userName, 'password': password, 'imageUrl': imageUrl};
  }

  UserModel copyWith({String? email, String? userName, String? password, String? imageUrl}) {
    return UserModel(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
