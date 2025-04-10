import 'package:bloc_clean_crud/core/constants/color_constants.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/bloc/user_update_create_bloc.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/bloc/user_update_create_event.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/bloc/user_update_create_state.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/view/user_create_update_page.dart';
import 'package:bloc_clean_crud/features/user_details/presentation/view/user_details_page.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/bloc/user_list_event.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_list_bloc.dart';
import '../bloc/user_list_state.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserListBloc>().add(FetchUserList(_currentPage));
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      _isFetchingMore = true;
      _currentPage++;
      context.read<UserListBloc>().add(FetchUserList(_currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserUpdateCreateBloc, UserUpdateCreateState>(
      listener: (context, state) {
        if (state is UserDeleteSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("User deleted successfully")));
          context.read<UserListBloc>().add(FetchUserList(1));
        }

        if (state is UserUpdateCreateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Something went wrong!")));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppColors.primary),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primaryLite,
                                child: Icon(
                                  Icons.group,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Users List",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  context.read<UserListBloc>().add(
                                    FetchUserList(1),
                                  );
                                },
                                icon: Icon(
                                  Icons.sync,
                                  color: AppColors.primary,
                                ),
                                label: Text(
                                  "Load User Data",
                                  style: TextStyle(color: AppColors.primary),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.deepPurple,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "No of Users",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
                  if (state is UserListLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (state is UserListLoaded) {
                    _isFetchingMore = false;
                    return ListView.separated(
                      controller: _scrollController,
                      separatorBuilder:
                          (context, index) => const Divider(height: 0.5),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: state.users.length + 1,

                      itemBuilder: (context, index) {
                        if (index == state.users.length) {
                          return Center(
                            child: Container(
                              width: 110,
                              height: 50,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Load More",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 20,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                child: Text(
                                  state.users[index].name[0],
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                backgroundColor: AppColors.primaryLite,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 15,
                                  children: [
                                    Text(
                                      state.users[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ActionButton(
                                          icon: Icons.edit_outlined,
                                          label: "Edit",
                                          color: AppColors.primary,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => UserFormPage(
                                                      userId:
                                                          state.users[index].id,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        ActionButton(
                                          icon: Icons.visibility_outlined,
                                          color: AppColors.primary,
                                          label: "View",
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => UserDetailsPage(
                                                      userId:
                                                          state.users[index].id,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        ActionButton(
                                          icon: Icons.delete_outline,
                                          color: Colors.red,
                                          label: "Delete",
                                          onTap: () {
                                            context
                                                .read<UserUpdateCreateBloc>()
                                                .add(
                                                  DeleteUserEvent(
                                                    state.users[index].id,
                                                  ),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (state is UserListError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UserFormPage()),
            );
          },
          child: Icon(Icons.add, color: AppColors.primary),
        ),
      ),
    );
  }
}
