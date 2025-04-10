import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserModel user;
  UserDetailsLoaded(this.user);
}

class UserDetailsError extends UserDetailsState {
  final String message;
  UserDetailsError(this.message);
}
