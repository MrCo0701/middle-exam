import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:middle_exam/feature/authentication/presentation/cubit/auth_cubit.dart';
import 'package:middle_exam/feature/authentication/presentation/cubit/auth_state.dart';
import 'package:middle_exam/feature/authentication/presentation/di/auth_di.dart';
import 'package:middle_exam/feature/authentication/presentation/widgets/button_custom.dart';
import 'package:middle_exam/feature/home/presentation/home_screen.dart';

import '../../../utils/helper/helper_function.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: isDarkMode ? Colors.black : Colors.white, centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: BlocProvider(
          create: (context) => provideAuth(),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.of(
                  context,
                ).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Column(
              children: [
                Lottie.asset("assets/animations/login_animation.json"),
                Builder(
                  builder: (context) {
                    return ButtonLoginCustom(
                      onPressed: context.read<AuthCubit>().signInWithGoogle,
                      text: 'Login With Google',
                      imageIcon: "assets/icons/login_icon.png",
                    );
                  },
                ),
                SizedBox(height: 20),
                // ButtonLoginCustom(onPressed: () {}, text: 'Sign up', imageIcon: "assets/icons/signup_icon.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
