import 'package:bloc_clean_crud/features/user_details/domain/repositories/user_details_repository.dart';
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';
import 'package:bloc_clean_crud/features/user_details/data/service/user_details_service.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsService service;

  UserDetailsRepositoryImpl(this.service);

  @override
  Future<UserModel> getUserDetails(int userId) {
    return service.getUserDetails(userId);
  }
}
