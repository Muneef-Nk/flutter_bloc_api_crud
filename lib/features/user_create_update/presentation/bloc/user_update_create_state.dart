// user_update_create_state.dart

abstract class UserUpdateCreateState {}

class UserUpdateCreateInitial extends UserUpdateCreateState {}

class UserUpdateCreateLoading extends UserUpdateCreateState {}

class UserCreateSuccess extends UserUpdateCreateState {}

class UserUpdateSuccess extends UserUpdateCreateState {}

class UserDeleteSuccess extends UserUpdateCreateState {}

class UserUpdateCreateError extends UserUpdateCreateState {
  final String message;
  UserUpdateCreateError(this.message);
}
