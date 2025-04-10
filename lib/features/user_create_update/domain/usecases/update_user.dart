import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

import '../repositories/user_update_create_repository.dart';

class UpdateUser {
  final UserUpdateCreateRepository repository;

  UpdateUser(this.repository);

  Future<UserModel> execute(int userId, UserModel user) async {
    return await repository.updateUser(userId, user);
  }
}
