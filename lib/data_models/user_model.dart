class UserModel {
  final String id;
  final String firstName,lastName,email;
  final String imageUrl;
  UserModel({
      required this.id,
      this.firstName="user",
      this.lastName="name",
      this.email="example@gmail.com",
      this.imageUrl = "assets/images/profile_image.png"}
      );
}