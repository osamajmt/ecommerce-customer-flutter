import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/checkinternet.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class Crud {
  Services myServices = Get.find();
  Future<Either<StatusRequest, Map>> getData(
    String link,
    Map<String, String>? headersData,
  ) async {
    try {
      if (await checkInternet()) {
        String? token = await myServices.secureStorage.read(key: "token");
        final headers = headersData ?? {};
          if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
        headers['Content-Type'] = 'application/json';
        headers['Accept'] = 'application/json';
        var response = await http.get(
          Uri.parse(link),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          print('Full Error Response: ${response.body}');
          print('Server error with status code: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
  Future<Either<StatusRequest, Map>> postData(
    String link,
    Map data,
    Map<String, String>? headersData,
  ) async {
    try {
      if (await checkInternet()) {
        String? token = await myServices.secureStorage.read(key: "token");

        final headers = headersData ?? {};

        headers['Content-Type'] = 'application/json';
        headers['Accept'] = 'application/json';
         if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
        final body = jsonEncode(data);
        var response = await http.post(
          Uri.parse(link),
          body: body,
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
          } 
         else if (response.statusCode == 401) {
         return const Left(StatusRequest.failure);
        }
        else {
          print('Full Error Response: ${response.body}');
          print('Server error with status code: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        print("no internet");
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> patchData(
    String link,
    Map data,
    Map<String, String>? headersData,
  ) async {
    try {
      if (await checkInternet()) {
        String? token = await myServices.secureStorage.read(key: "token");

        final headers = headersData ?? {};

        if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
        headers['Content-Type'] = 'application/json';
        headers['Accept'] = 'application/json';
        final body = jsonEncode(data);
        var response = await http.patch(
          Uri.parse(link),
          body: body,
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          print('Full Error Response: ${response.body}');
          print('Server error with status code: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(
    String link,
    Map data,
    Map<String, String>? headersData,
  ) async {
    try {
      if (await checkInternet()) {
        String? token = await myServices.secureStorage.read(key: "token");

        final headers = headersData ?? {};
          if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
        headers['Content-Type'] = 'application/json';
        headers['Accept'] = 'application/json';
        final body = jsonEncode(data);
        var response = await http.delete(
          Uri.parse(link),
          body: body,
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          print('Full Error Response: ${response.body}');
          print('Server error with status code: ${response.statusCode}');
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
