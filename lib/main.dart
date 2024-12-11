import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/core/utils/app_themes.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_bloc.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_bloc.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_bloc.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:booki_app/feature/intro_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorge.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context)=>WishlistBloc()),
        BlocProvider(create: (context)=>CartBloc()),
        BlocProvider(create: (context)=>ProfileBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.themeData,
        home: const SplashScreen(),
      ),
    );
  }
}
