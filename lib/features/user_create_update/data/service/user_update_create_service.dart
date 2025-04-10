import 'dart:convert';
import 'package:bloc_clean_crud/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

abstract class UserUpdateCreateService {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> updateUser(int userId, UserModel user);
  Future<void> deleteUser(int userId);
}

class UserUpdateCreateServiceImpl implements UserUpdateCreateService {
  Map<String, String> get _headers => {
    'Authorization': 'Bearer ${ApiClient.token}',
    'Content-Type': 'application/json',
  };

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse(ApiClient.baseUrl),
      headers: _headers,
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to create user: ${response.body}');
  }

  @override
  Future<UserModel> updateUser(int userId, UserModel user) async {
    final response = await http.put(
      Uri.parse('${ApiClient.baseUrl}/$userId'),
      headers: _headers,
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to update user: ${response.body}');
  }

  @override
  Future<void> deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('${ApiClient.baseUrl}/$userId'),
      headers: _headers,
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete user: ${response.body}');
    }
  }
}
