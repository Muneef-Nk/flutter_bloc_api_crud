import 'package:bloc_clean_crud/core/constants/color_constants.dart';
import 'package:bloc_clean_crud/core/di/service_locator.dart';
import 'package:bloc_clean_crud/features/user_details/domain/usecases/get_user_details.dart';
import 'package:bloc_clean_crud/features/user_list/data/model/user_model.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/bloc/user_list_bloc.dart';
import 'package:bloc_clean_crud/features/user_list/presentation/bloc/user_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_update_create_bloc.dart';
import '../bloc/user_update_create_event.dart';
import '../bloc/user_update_create_state.dart';

class UserFormPage extends StatelessWidget {
  final int? userId;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final ValueNotifier<String> _gender = ValueNotifier<String>('male');
  final ValueNotifier<String> _status = ValueNotifier<String>('active');

  UserFormPage({this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    final isUpdate = userId != null;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: BlocListener<UserUpdateCreateBloc, UserUpdateCreateState>(
          listener: (context, state) {
            if (state is UserCreateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User created successfully")),
              );
              context.read<UserListBloc>().add(FetchUserList(1));
              Navigator.pop(context);
            }

            if (state is UserUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User updated successfully")),
              );
              context.read<UserListBloc>().add(FetchUserList(1));
              Navigator.pop(context);
            }

            if (state is UserUpdateCreateError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Something went wrong!")));
              Navigator.pop(context);
            }
          },
          child: Column(
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
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Edit Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 30,
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

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      isUpdate
                          ? FutureBuilder<UserModel>(
                            future: di<GetUserDetails>().execute(userId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }

                              final user = snapshot.data!;
                              _nameController = TextEditingController(
                                text: user.name,
                              );
                              _emailController = TextEditingController(
                                text: user.email,
                              );
                              _gender.value = user.gender;
                              _status.value = user.status;

                              return _buildForm(context, isUpdate);
                            },
                          )
                          : _buildForm(context, isUpdate),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<UserUpdateCreateBloc, UserUpdateCreateState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = UserModel(
                            id: isUpdate ? userId! : 0,
                            name: _nameController.text,
                            email: _emailController.text,
                            gender: _gender.value,
                            status: _status.value,
                          );
                          if (isUpdate) {
                            context.read<UserUpdateCreateBloc>().add(
                              UpdateUserEvent(userId!, user),
                            );
                          } else {
                            context.read<UserUpdateCreateBloc>().add(
                              CreateUserEvent(user),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          state is UserUpdateCreateLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                isUpdate ? 'Update' : 'Create',
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isUpdate) {
    if (!isUpdate) {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
    }

    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        children: [
          _buildTextField('Name', _nameController),
          _buildTextField('Email', _emailController),
          SizedBox(height: 10),
          _buildDropdown('Gender', _gender, const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ]),
          SizedBox(height: 10),
          _buildDropdown('Status', _status, const [
            DropdownMenuItem(value: 'active', child: Text('Active')),
            DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
          ]),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          validator: (value) => value!.isEmpty ? '$label is required' : null,
        ),
      ],
    );
  }

  Widget _buildDropdown(
    String label,
    ValueNotifier<String> notifier,
    List<DropdownMenuItem<String>> items,
  ) {
    return ValueListenableBuilder<String>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
          items: items,
          onChanged: (newValue) {
            if (newValue != null) notifier.value = newValue;
          },
        );
      },
    );
  }
}
