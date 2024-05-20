// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class UserModel {
  final int? id;
  final String? username;
  final String? password;
  final String? aksesLevel;
  final String? nama;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token;
  final int? tokenExpireIn;
  final String? tokenType;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.aksesLevel,
    this.nama,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.tokenExpireIn,
    this.tokenType,
  });

  UserModel copyWith({
    int? id,
    String? username,
    String? password,
    String? aksesLevel,
    String? nama,
    String? email,
    dynamic emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
    int? tokenExpireIn,
    String? tokenType,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        aksesLevel: aksesLevel ?? this.aksesLevel,
        nama: nama ?? this.nama,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
        tokenExpireIn: tokenExpireIn ?? this.tokenExpireIn,
        tokenType: tokenType ?? this.tokenType,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        aksesLevel: json["akses_level"],
        nama: json["nama"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        token: json["token"],
        tokenExpireIn: json["token_expire_in"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "akses_level": aksesLevel,
        "nama": nama,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "token": token,
        "token_expire_in": tokenExpireIn,
        "token_type": tokenType,
      };
}
