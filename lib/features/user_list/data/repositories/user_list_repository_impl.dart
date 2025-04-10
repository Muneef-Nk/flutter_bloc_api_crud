import 'package:bloc_clean_crud/features/user_list/data/service/get_user_service.dart';
import 'package:bloc_clean_crud/features/user_list/domain/entities/user_entity.dart';

import '../../domain/repositories/user_list_repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListService service;

  UserListRepositoryImpl(this.service);

  @override
  Future<List<User>> getUserList(int page) async {
    final userModels = await service.getUserList(page);
    return userModels
        .map(
          (model) => User(
            id: model.id,
            name: model.name,
            email: model.email,
            gender: model.gender,
            status: model.status,
          ),
        )
        .toList();
  }
}
