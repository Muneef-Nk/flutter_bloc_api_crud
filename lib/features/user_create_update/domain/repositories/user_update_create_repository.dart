import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

abstract class UserUpdateCreateRepository {
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> updateUser(int userId, UserModel user);
  Future<void> deleteUser(int userId);
}
