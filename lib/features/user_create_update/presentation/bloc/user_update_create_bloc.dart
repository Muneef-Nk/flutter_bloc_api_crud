import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/update_user.dart';
import '../../domain/usecases/delete_user.dart';
import 'user_update_create_event.dart';
import 'user_update_create_state.dart';

class UserUpdateCreateBloc extends Bloc<UserUpdateCreateEvent, UserUpdateCreateState> {
  final CreateUser createUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser;

  UserUpdateCreateBloc({
    required this.createUser,
    required this.updateUser,
    required this.deleteUser,
  }) : super(UserUpdateCreateInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(UserUpdateCreateLoading());
      try {
        await createUser.execute(event.user);
        emit(UserCreateSuccess());
      } catch (e) {
        emit(UserUpdateCreateError(e.toString()));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserUpdateCreateLoading());
      try {
        await updateUser.execute(event.userId, event.user);
        emit(UserUpdateSuccess());
      } catch (e) {
        emit(UserUpdateCreateError(e.toString()));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(UserUpdateCreateLoading());
      try {
        await deleteUser.execute(event.userId);
        emit(UserDeleteSuccess());
      } catch (e) {
        emit(UserUpdateCreateError(e.toString()));
      }
    });
  }
}
