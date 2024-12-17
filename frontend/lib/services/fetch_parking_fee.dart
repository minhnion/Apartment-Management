import 'dart:convert';

import 'package:frontend/models/parking_fee_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

Future<ParkingFeeResponse?> fetchRequiredFees() async {
  const url = 'https://apartment-management-kjj9.onrender.com/admin/park-fee'; // Thay URL bằng URL thật của API
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenlogin = prefs.getString('tokenlogin');
    print(tokenlogin);
    Map<String, String> headers = {
      'Authorization': 'Bearer $tokenlogin',
      'Content-Type': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      print('Success');
      print('Response body: ${response.body}'); // In ra dữ liệu JSON từ server

      // Giải mã JSON và trả về FeeResponse
      return ParkingFeeResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      print('Invalid household ID or request format.');
    } else if (response.statusCode == 404) {
      print('Household ID not found.');
    } else if (response.statusCode == 500) {
      print('Internal server error.');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
