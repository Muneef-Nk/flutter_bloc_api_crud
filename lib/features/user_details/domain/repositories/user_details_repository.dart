import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';

abstract class UserDetailsRepository {
  Future<UserModel> getUserDetails(int userId);
}
