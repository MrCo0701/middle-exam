import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:middle_exam/feature/home/data/model/user_model.dart';
import 'package:middle_exam/feature/home/presentation/cubit/home_cubit.dart';
import 'package:middle_exam/feature/home/presentation/cubit/home_state.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key, required this.user, required this.onPress});

  final UserModel user;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onPress,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              context.read<HomeCubit>().deleteUser(user.email);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delete user', style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red,
                ),
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                // , borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      user.imageUrl,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.black12,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Email: ', style: TextStyle(fontWeight: FontWeight.w600)),
                            Expanded(child: Text(user.email, overflow: TextOverflow.ellipsis)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('UserName: ', style: TextStyle(fontWeight: FontWeight.w600)),
                            Expanded(child: Text(user.userName)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Password: ', style: TextStyle(fontWeight: FontWeight.w600)),
                            Expanded(child: Text(user.password)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
