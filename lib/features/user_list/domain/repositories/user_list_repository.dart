import 'package:bloc_clean_crud/features/user_list/domain/entities/user_entity.dart';

abstract class UserListRepository {
  Future<List<User>> getUserList(int page);
}
