class UsersModel {
  final String uid;
  final String email;
  final String? name;
  // final String? avataUrl;

  UsersModel({
    required this.uid,
    required this.email,
    required this.name,
    // required this.avataUrl,
  });

  factory UsersModel.fromMap(Map<String, dynamic> map, String uid) {
    return UsersModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'],
      // avataUrl: map['avataUrl'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email, 'name': name,
      // 'avatarUrl': avataUrl
    };
  }
}
