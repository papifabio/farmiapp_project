import 'dart:convert';

class UserModel {
  String id;
  int mobile;
  int document;
  String user;
  String email;
  String password;
  String? url_photo;

  UserModel(
      {required this.id,
      required this.mobile,
      required this.user,
      required this.email,
      required this.password,
      required this.document,
      this.url_photo});

  factory UserModel.fromJson(String str) => UserModel.fromMap(jsonDecode(str));
  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        mobile: json["mobile"],
        user: json["user"],
        email: json["email"],
        document: json["document"],
        url_photo: json["url_photo"],
        password: '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "mobile": mobile,
        "user": user,
        "email": email,
        "document": document,
        "url_photo": url_photo,
      };
}
