import 'package:equatable/equatable.dart';

abstract class UserDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserDetails extends UserDetailsEvent {
  final int userId;
  FetchUserDetails(this.userId);
}
