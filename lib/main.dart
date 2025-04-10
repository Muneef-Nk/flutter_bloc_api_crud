import 'package:bloc_clean_crud/features/user_create_update/presentation/bloc/user_update_create_bloc.dart';
import 'package:bloc_clean_crud/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/view/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'features/user_list/presentation/bloc/user_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserListBloc>(create: (_) => di<UserListBloc>()),
        BlocProvider<UserDetailsBloc>(create: (_) => di<UserDetailsBloc>()),
        BlocProvider<UserUpdateCreateBloc>(create: (_) => di<UserUpdateCreateBloc>()),
      ],
      child: MaterialApp(
        title: 'BLoC Clean CRUD',
        home: UserListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
