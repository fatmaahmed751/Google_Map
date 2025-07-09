

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
//import '../../Modules/Auth/Register/register_screen.dart';
//import '../../Utilities/dialog_helper.dart';
//import '../../Utilities/router_config.dart';
//import '../../Utilities/shared_preferences.dart';
//import '../../Utilities/strings.dart';
//import '../../Widgets/un_login_for_rated_widget.dart';
import '../../utilitis/shared_preferences.dart';
import '../error/exceptions.dart';
import '../network/error_message_model.dart';

class RequestApi {
  final Uri uri;
  final Map<String, String> body;
  final Map<String, dynamic> bodyJson;
  final List<http.MultipartFile> files;
  final Map<String, String>? headers;
  final String method;

  RequestApi.post({
    required String url,
    required this.body,
    this.files = const [],
    this.headers,
  })  : method = "POST",
        uri = Uri.parse(url),
        bodyJson = {};
  RequestApi.postJson({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "POST",
        uri = Uri.parse(url),
        files = [],
        body = {};

  RequestApi.postUri({
    required this.uri,
    this.bodyJson = const {},
    this.body = const {},
    this.files = const [],
    this.headers,
  })  : method = "POST" ;

  RequestApi.put({
    required String url,
    required this.body,
    this.files = const [],
    this.headers,
  })  : method = "PUT",
        uri = Uri.parse(url),
        bodyJson = {};
  RequestApi.putJson({
    required String url,
    required this.bodyJson,
    this.headers,
  })  : method = "PUT",
        uri = Uri.parse(url),
        files = [],
        body = {};

  RequestApi.get({
    required String url,
    this.headers,
  })  : method = "GET",
        body = {},
        files = [],
        uri = Uri.parse(url),
        bodyJson = {};
  RequestApi.getUri({
    required this.uri,
    this.headers,
  })  : method = "GET",
        body = {},
        files = [],
        bodyJson = {};

  RequestApi.delete({
    required String url,
    this.headers,
  })  : method = "DELETE",
        body = {},
        files = [],
        uri = Uri.parse(url),
        bodyJson = {};
  RequestApi.deleteUri({
    required this.uri,
    this.headers,
  })  : method = "DELETE",
        body = {},
        files = [],
        bodyJson = {};

  RequestApi.customMethod({
    required this.method,
    this.bodyJson = const {},
    required String url,
    this.headers,
    this.files = const [],
    this.body = const {},
  }) : uri = Uri.parse(url);
  RequestApi.customMethodUri({
    required this.method,
    required this.uri,
    this.bodyJson = const {},
    this.headers,
    this.files = const [],
    this.body = const {},
  });

  Future<dynamic> request({bool getResponseBytes = false}) async {
    debugPrint(uri.toString());
    debugPrint(json.encode(body));
    var request = http.MultipartRequest(method, uri);
    if(body.isNotEmpty) request.fields.addAll(body);
    request.files.addAll(files);
    if (headers != null) request.headers.addAll(headers!);
    return await ApiBaseHelper.httpSendRequest(request,this,getResponseBytes: getResponseBytes);
  }

  Future<dynamic> requestJson({bool getResponseBytes = false}) async {
    debugPrint(uri.toString());
    debugPrint(json.encode(bodyJson));
    var request = http.Request(method, uri);
    request.body = json.encode(bodyJson);
    if (headers != null) request.headers.addAll(headers!);
    return await ApiBaseHelper.httpSendRequest(request,this,getResponseBytes: getResponseBytes);
  }
}

class ApiBaseHelper {
  static Future<dynamic> httpSendRequest(http.BaseRequest request,
      RequestApi requestApi, {bool getResponseBytes = false}) async {
    http.StreamedResponse response;
    try {
      request.headers.addAll({
       'Accept': '*/*',
        'content-type': 'application/json',
        "locale": SharedPref.getCurrentLanguage() ?? "en",
        //if (token != null) "Authorization": 'Bearer $token',
       // "Authorization": 'Bearer ${SharedPref.getCurrentUser()?.token.toString()}',
       // if (token != null) "Authorization": 'Bearer $token',
       //"Authorization": 'Bearer ${SharedPref.getCurrentUser()?.token.toString()}'
       //'Bearer ${SharedPref.getCurrentUser()?.token.toString()}',
      });

      response = await request.send().timeout(const Duration(seconds: 180));
      AnsiPen pen = AnsiPen()
        ..green(bold: true);
      debugPrint(pen("statusCode: ${response.statusCode}"));
    } on SocketException {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: "No Internet Connection",
          requestApi: requestApi,
        ),
      );
    } on FormatException {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: "Bad Format",
          requestApi: requestApi,
        ),
      );
    } on Exception {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
          statusCode: 500,
          statusMessage: 'Unexpected error 😢',
          requestApi: requestApi,
        ),
      );
    }
    if (getResponseBytes) return await response.stream.toBytes();
    return _returnResponse(response, requestApi);
  }

  static Future<dynamic> _returnResponse(http.StreamedResponse response,
      RequestApi requestApi) async {
    if(response.statusCode == 401){
      // DialogHelper.custom(context: currentContext_!).customDialog(
      //     dialogWidget: UnLoginForRatedWidget(
      //       des: Strings.hintForUserReview.tr,
      //       onButtonAccept: () {
      //         GoRouter.of(currentContext_!).pushNamed(RegisterScreen.routeName);
      //         currentContext_!.pop();
      //       },
      //       onButtonReject: () {
      //         GoRouter.of(currentContext_!).pushNamed(HomeScreen.routeName);
      //       },
      //       // titleButtonAccept: Strings.yes.tr,
      //       // titleButtonReject: Strings.cancel.tr,
      //     ),
      //     dismiss: false);
    }
    String resStream =
   await response.stream.bytesToString();
    Map<String, dynamic> jsonResponse = {};
    
    ServerException serverException({String? message})=>

      ServerException(
        errorMessageModel: ErrorMessageModel(
            statusCode: response.statusCode,
            statusMessage: message,
            requestApi: requestApi,
            responseApi: jsonResponse
        ),
      );

    try{
      jsonResponse = jsonDecode(resStream) as Map<String,dynamic>;
    }catch(e) {
      throw ServerException(
        errorMessageModel: ErrorMessageModel(
            statusCode: response.statusCode,
            requestApi: requestApi,
            responseApi: {
              "_THIS_KEY_FROM_APP_THERE_IS_NO_KEY_GETTING_": resStream
            }
        ),
      );
    
    }
        AnsiPen pen = AnsiPen()
          ..green(bold: true);
        debugPrint(pen("$jsonResponse"));

        switch (response.statusCode) {
          case 200:
            {
              if (jsonResponse["success"] == false) {
                throw serverException(message: jsonResponse["message"]);
              }
              return jsonResponse;
            }
          default:
            throw serverException(message: jsonResponse["message"]);
        }
      }

    }
  
