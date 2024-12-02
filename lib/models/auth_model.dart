class LoginResponse {
  final bool status;
  final int errorCode;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.status,
    required this.errorCode,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as bool,
      errorCode: json['errorCode'] as int,
      message: json['message'] as String,
      data: json['data'] != null
          ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class LoginData {
  final User user;
  final Auth auth;

  LoginData({required this.user, required this.auth});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      auth: Auth.fromJson(json['auth'] as Map<String, dynamic>),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? imgUrl;
  final String mobileNumber;
  final String? countryCode;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.imgUrl,
    required this.mobileNumber,
    this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      imgUrl: json['imgUrl'] as String?,
      mobileNumber: json['mobileNumber'] as String,
      countryCode: json['countryCode'] as String?,
    );
  }
}

class Auth {
  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Auth({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}
