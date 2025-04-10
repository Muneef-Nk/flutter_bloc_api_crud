import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_details.dart';
import 'user_details_event.dart';
import 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final GetUserDetails getUserDetails;

  UserDetailsBloc(this.getUserDetails) : super(UserDetailsInitial()) {
    on<FetchUserDetails>((event, emit) async {
      emit(UserDetailsLoading());
      try {
        final user = await getUserDetails.execute(event.userId);
        emit(UserDetailsLoaded(user));
      } catch (e) {
        emit(UserDetailsError(e.toString()));
      }
    });
  }
}
