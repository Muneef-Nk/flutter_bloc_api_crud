import 'package:bloc_clean_crud/features/user_list/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

// class UserListLoaded extends UserListState {
//   final List<User> users;
//   UserListLoaded(this.users);
// }

class UserListError extends UserListState {
  final String message;
  UserListError(this.message);
}

class UserListLoaded extends UserListState {
  final List<User> users;
  final bool isLoadingMore;

  UserListLoaded(this.users, {this.isLoadingMore = false});

  UserListLoaded copyWith({List<User>? users, bool? isLoadingMore}) {
    return UserListLoaded(
      users ?? this.users,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [users, isLoadingMore];
}
