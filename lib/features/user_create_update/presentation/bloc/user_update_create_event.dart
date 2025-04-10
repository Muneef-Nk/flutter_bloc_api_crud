import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserUpdateCreateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserUpdateCreateEvent {
  final UserModel user;
  CreateUserEvent(this.user);
}

class UpdateUserEvent extends UserUpdateCreateEvent {
  final int userId;
  final UserModel user;
  UpdateUserEvent(this.userId, this.user);
}

class DeleteUserEvent extends UserUpdateCreateEvent {
  final int userId;
  DeleteUserEvent(this.userId);
}
