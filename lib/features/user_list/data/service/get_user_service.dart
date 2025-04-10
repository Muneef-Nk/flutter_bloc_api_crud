import 'dart:convert';
import 'package:bloc_clean_crud/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

abstract class UserListService {
  Future<List<UserModel>> getUserList(int page);
}

class UserListServiceImpl implements UserListService {
  @override
  Future<List<UserModel>> getUserList(int page) async {
    final url = Uri.parse('${ApiClient.baseUrl}?page=$page&per_page=7');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${ApiClient.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }
}
