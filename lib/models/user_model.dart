class UserModel {
  final UserType userType;

  UserModel({required this.userType});
}

enum UserType {
  rentalUser,
  serviceProvider,
}
