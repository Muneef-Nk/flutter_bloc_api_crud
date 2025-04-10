import 'package:bloc_clean_crud/features/user_list/domain/entities/user_entity.dart';

import '../repositories/user_list_repository.dart';

class GetUserList {
  final UserListRepository repository;

  GetUserList(this.repository);

  Future<List<User>> execute(int page) async {
    return await repository.getUserList(page);
  }
}
