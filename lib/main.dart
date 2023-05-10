import 'package:crypto_application_git/screens/home_screen.dart';
import 'package:crypto_application_git/screens/splash_screen.dart';
import 'package:crypto_application_git/theme/theme.dart';
import 'package:crypto_application_git/theme/theme_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

   runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.isDark?appThemeData[AppTheme.dart]:appThemeData[AppTheme.light],
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

