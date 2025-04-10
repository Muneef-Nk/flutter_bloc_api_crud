import 'package:bloc_clean_crud/features/user_list/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_list_repository.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListRepository repository;

  UserListBloc(this.repository) : super(UserListInitial()) {
    on<FetchUserList>((event, emit) async {
      try {
        // If we're loading first page, show loading indicator
        if (event.page == 1) {
          emit(UserListLoading());
        }

        final users = await repository.getUserList(event.page);

        if (state is UserListLoaded && event.page != 1) {
          final currentUsers = (state as UserListLoaded).users;
          final allUsers = List<User>.from(currentUsers)..addAll(users);
          emit(UserListLoaded(allUsers));
        } else {
          emit(UserListLoaded(users));
        }
      } catch (e) {
        emit(UserListError(e.toString()));
      }
    });
  }
}
