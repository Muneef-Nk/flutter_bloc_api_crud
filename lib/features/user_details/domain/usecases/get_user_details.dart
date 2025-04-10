import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

import '../repositories/user_details_repository.dart';

class GetUserDetails {
  final UserDetailsRepository repository;

  GetUserDetails(this.repository);

  Future<UserModel> execute(int userId) async {
    return await repository.getUserDetails(userId);
  }
}
