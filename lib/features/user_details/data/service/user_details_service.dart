import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

abstract class UserDetailsService {
  Future<UserModel> getUserDetails(int userId);
}

class UserDetailsServiceImpl implements UserDetailsService {
  final String baseUrl = 'https://gorest.co.in/public/v2/users';
  final String token = '090a4d13b368ea5cbc5c1f05cd08a2b0cb5cd4234b51f1b2aa2a8e6a4edaf183';

  @override
  Future<UserModel> getUserDetails(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user details: ${response.statusCode}');
    }
  }
}
