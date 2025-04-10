import 'package:bloc_clean_crud/features/user_create_update/domain/repositories/user_update_create_repository.dart';
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';
import 'package:bloc_clean_crud/features/user_create_update/data/service/user_update_create_service.dart';

class UserUpdateCreateRepositoryImpl implements UserUpdateCreateRepository {
  final UserUpdateCreateService service;

  UserUpdateCreateRepositoryImpl(this.service);

  @override
  Future<UserModel> createUser(UserModel user) {
    return service.createUser(user);
  }

  @override
  Future<UserModel> updateUser(int userId, UserModel user) {
    return service.updateUser(userId, user);
  }

  @override
  Future<void> deleteUser(int userId) {
    return service.deleteUser(userId);
  }
}
