import '../repositories/user_update_create_repository.dart';

class DeleteUser {
  final UserUpdateCreateRepository repository;

  DeleteUser(this.repository);

  Future<void> execute(int userId) async {
    await repository.deleteUser(userId);
  }
}
