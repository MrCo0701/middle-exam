import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:middle_exam/feature/home/data/model/user_model.dart';
import 'package:middle_exam/feature/home/presentation/cubit/home_cubit.dart';
import 'package:middle_exam/feature/home/presentation/cubit/home_state.dart';

class DialogCustom extends StatelessWidget {
  DialogCustom({super.key, required this.bloc, this.user});

  final HomeCubit bloc;
  final UserModel? user;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      _emailController.text = user!.email;
      _userNameController.text = user!.userName;
      _passwordController.text = user!.password;
    }

    return BlocProvider.value(
      value: bloc,
      child: AlertDialog(
        title: Text(user != null ? 'Change user' : 'Add new user'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "email not null";
                        if (!value.contains("@")) return "invalid email";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(hintText: 'UserName', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.length < 3) return "at least 3 characters";
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.length < 6) return "at least 6 characters";
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return state.imageUrl != '' || user != null
                        ? Stack(
                            children: [
                              state.imageUrl == '' ? Image.network(user!.imageUrl) : Image.file(File(state.imageUrl)),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () => context.read<HomeCubit>().removeImage(),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Icon(Icons.close, color: Colors.black, size: 14, weight: 600),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container();
                  },
                ),
                Row(
                  children: [
                    IconButton(onPressed: () => bloc.pickImage(), icon: Icon(Icons.photo_library_outlined)),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newUser = UserModel(
                              email: _emailController.text,
                              userName: _userNameController.text,
                              password: _passwordController.text,
                              imageUrl: bloc.state.imageUrl != '' ? bloc.state.imageUrl : user!.imageUrl,
                            );

                            bloc.state.imageUrl == '' && user != null
                                ? bloc.updateUser(newUser)
                                : bloc.addUser(newUser);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Add user success', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                        child: Text('Add User', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
