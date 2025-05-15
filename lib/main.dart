import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/auth/bloc/auth_bloc.dart';
import 'src/auth/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
        // Add RepoBloc, BranchBloc etc. here if needed globally
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Task App',
        home: SplashScreen(),
      ),
    );
  }
}

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthInitial) {
//           return SplashScreen();
//         } else if (state is Authenticated) {
//           return RepoListScreen(); // Pass token if needed
//         } else if (state is Unauthenticated || state is AuthError) {
//           return LoginScreen();
//         } else if (state is AuthLoading) {
//           return SplashScreen(); // Or loading widget
//         }
//         return Center(child: Text("Unknown state"));
//       },
//     );
//   }
// }
