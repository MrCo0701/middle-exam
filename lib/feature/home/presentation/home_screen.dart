import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:middle_exam/feature/authentication/presentation/login_screen.dart';
import 'package:middle_exam/feature/home/data/model/user_model.dart';
import 'package:middle_exam/feature/home/presentation/cubit/home_state.dart';
import 'package:middle_exam/feature/home/presentation/di/home_di.dart';
import 'package:middle_exam/feature/home/presentation/widgets/dialog_custom.dart';
import 'package:middle_exam/feature/home/presentation/widgets/user_information.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => provideHomeCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (innerContext) {
              return IconButton(
                onPressed: () {
                  innerContext.read<HomeCubit>().signOut();
                  Navigator.of(
                    context,
                  ).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
                },
                icon: Icon(Icons.arrow_back, color: Colors.red),
              );
            }
          ),
          actions: [
            Builder(
              builder: (innerContext) {
                return IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: innerContext.read<HomeCubit>(),
                      child: DialogCustom(bloc: provideHomeCubit()),
                    ),
                  ),
                  icon: Icon(Icons.add),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 30, backgroundImage: NetworkImage(user!.photoURL ?? '')),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user!.displayName ?? '', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
                        Text(
                          user!.email ?? '',
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 2,
                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(30)),
              ),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Users').snapshots(),
                    builder: (context, asyncSnapshot) {
                      if (!asyncSnapshot.hasData) return Text('Empty Data');

                      return SingleChildScrollView(
                        child: Builder(
                          builder: (innerContext) {
                            return Column(
                              spacing: 10,
                              children: asyncSnapshot.data!.docs
                                  .map(
                                    (e) => UserInformation(
                                      user: UserModel.fromJson(e.data()),
                                      onPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => BlocProvider.value(
                                            value: innerContext.read<HomeCubit>(),
                                            child: DialogCustom(
                                              bloc: provideHomeCubit(),
                                              user: UserModel.fromJson(e.data()),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
