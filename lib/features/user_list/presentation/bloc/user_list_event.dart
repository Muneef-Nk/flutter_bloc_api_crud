import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserList extends UserListEvent {
  final int page;
  FetchUserList(this.page);
}
