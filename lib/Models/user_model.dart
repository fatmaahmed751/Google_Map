// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserModel {
//   final String uId;
//   final String phoneNumber;
//   final String password;
//
//   UserModel({
//     required this.uId,
//     required this.phoneNumber,
//     required this.password,
//   });
//
//   // Factory constructor to create UserModel from Firebase User
//   factory UserModel.fromJson(User user) {
//     return UserModel(
//       uId: user.uid,
//       phoneNumber: user.phoneNumber ?? '',
//       password: '',
//     );
//   }
//   Map<String,dynamic>toJson(){
//     return{
//       'uId':uId,
//       'phone':phoneNumber,
//       'password':password,
//     };
//   }
// }
class UserModel {

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel();
  Map<String, dynamic> toJson() => {};
}