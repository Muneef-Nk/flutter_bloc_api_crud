import 'package:bloc_clean_crud/core/constants/color_constants.dart';
import 'package:bloc_clean_crud/features/user_create_update/presentation/view/user_create_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_details_bloc.dart';
import '../bloc/user_details_event.dart';
import '../bloc/user_details_state.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  const UserDetailsPage({required this.userId, super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserDetailsBloc>().add(FetchUserDetails(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          if (state is UserDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is UserDetailsLoaded) {
            final user = state.user;

            return Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.16,
                          width: double.infinity,
                          decoration: BoxDecoration(color: AppColors.primary),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 53,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryLite,
                          radius: 50,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 50,
                      left: 20,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Text(
                  "${user.name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    spacing: 25,
                    children: [
                      _buildDetailRow(Icons.email, "Email", user.email),
                      _buildDetailRow(Icons.person, "Gender", user.gender),
                      _buildDetailRow(
                        Icons.verified_user,
                        "Status",
                        user.status,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is UserDetailsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserFormPage(userId: widget.userId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Edit Details',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primaryLite,
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text('${value}', maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
