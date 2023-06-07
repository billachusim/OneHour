class UserModel {
  String? userId;
  String? nickname;
  String? phoneNumber;
  String? email;
  String? password;
  String? age;
  String? gender;
  String? city;
  String? userType;

  UserModel({
    this.userId,
    this.nickname,
    this.phoneNumber,
    this.email,
    this.password,
    this.age,
    this.gender,
    this.city,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      nickname: json['nickname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      city: json['city'] ?? '',
      userType: json['userType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'city': city,
      'userType': userType,
    };
  }


  fromJson(Map<String, dynamic> map) {
    return {
      'userId': userId,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'city': city,
      'userType': userType,
    };
  }

}
