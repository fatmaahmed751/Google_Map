// import '../network/error_message_model.dart';
//
// abstract class Failure {
//   final String message;
//   const Failure(this.message);
// }
//
// class ServerFailure extends Failure {
//   final ErrorMessageModel errorMessageModel;
//   ServerFailure(this.errorMessageModel) : super(errorMessageModel.statusMessage);
// }
//
// // New class for external services
// class ExternalServiceFailure extends Failure {
//   final int? statusCode;
//   final Map<String, dynamic>? rawResponse;
//
//   ExternalServiceFailure({
//     required String message,
//     this.statusCode,
//     this.rawResponse,
//   }) : super(message);
// }