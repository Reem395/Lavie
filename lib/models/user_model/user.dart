class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  dynamic address;
  String? role;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.address,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        imageUrl: json['imageUrl'] as String?,
        address: json['address'] as dynamic,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
        'address': address,
        'role': role,
      };
}
