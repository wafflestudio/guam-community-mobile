import 'dart:convert';
import 'dart:io' show File, HttpHeaders;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import '../mixins/toast.dart';

class HttpRequest with Toast {
  final String gatewayAuthority = "guam.jon-snow-korea.com";
  final String immigrationAuthority = "guam-immigration.jon-snow-korea.com";
  final String s3BaseAuthority = "https://guam.s3.ap-northeast-2.amazonaws.com/";

  Future get({String authority, String path, dynamic queryParams, String authToken}) async {
    try {
      final uri = Uri.https(authority ?? gatewayAuthority, path, queryParams);
      final response = await http.get(
        uri,
        headers: {'Content-Type': "application/json", 'Authorization': 'Bearer $authToken'},
      );

      return response;
    } catch (e) {
      print("Error on GET request: $e");
      // TODO: impl toast
      // showToast(success: false);
    }
  }

  Future post({String authority, String path, String authToken, dynamic queryParams, dynamic body}) async {
    try {
      final uri = Uri.https(authority ?? gatewayAuthority, path, queryParams);

      final response = await http.post(
        uri,
        headers: {'Content-Type': "application/json", 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      print("Error on POST request: $e");
      // TODO: impl toast
      // showToast(success: false);
    }
  }

  Future postMultipart({String authority, String path, String authToken, Map<String, dynamic> fields, List<File> files}) async {
    try {
      final uri = Uri.https(authority ?? gatewayAuthority, path);

      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = 'Bearer $authToken';
      fields.entries.forEach((e) => request.fields[e.key] = e.value);

      if (files != null)
        files.forEach((e) async {
          final multipartFile = http.MultipartFile(
              "imageFiles",
              e.readAsBytes().asStream(),
              e.lengthSync(),
              filename: e.path.split("/").last,
              contentType: MediaType("image", "${p.extension(e.path)}")
          );
          request.files.add(multipartFile);
        });
      final response = await request.send();

      return response;
    } catch (e) {
      print("Error on POST Multipart request: $e");
      // TODO: impl toast
      // showToast(success: false);
    }
  }

  Future put({String authority, String path, String authToken, dynamic body}) async {
    try {
      final uri = Uri.https(authority ?? gatewayAuthority, path);

      final response = await http.put(
        uri,
        headers: {'Content-Type': "application/json", 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      print("Error on PUT request: $e");
      // TODO: impl toast
      // showToast(success: false);
    }
  }

  Future delete({String authority, String path, String authToken}) async {
    try {
      final uri = Uri.https(authority ?? gatewayAuthority, path);
      final response = await http.delete(
        uri,
        headers: {'Content-Type': "application/json", 'Authorization': 'Bearer $authToken'},
      );

      return response;
    } catch (e) {
      print("Error on DELETE request: $e");
      // TODO: impl toast
      // showToast(success: false);
    }
  }
}
