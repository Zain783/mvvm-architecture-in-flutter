import 'dart:convert';
import 'dart:io';
import 'package:flutter_mvvm_architecture/data/app_excaptions.dart';
import 'package:flutter_mvvm_architecture/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      //it is internet exception ot no network exception
    } on SocketException {
      //FetchDataException this is over own built in exception class whcih we have already created
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      //it is internet exception ot no network exception
    } on SocketException {
      //FetchDataException this is over own built in exception class whcih we have already created
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        BadRequestException(response.body.toString());
        break;
      case 404:
        UnauthorisedDataException(response.body.toString());
        break;
      case 500:
        BadRequestException(response.body.toString());
        break;
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
