import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

import '../repositories/user_update_create_repository.dart';

class CreateUser {
  final UserUpdateCreateRepository repository;

  CreateUser(this.repository);

  Future<UserModel> execute(UserModel user) async {
    return await repository.createUser(user);
  }
}
