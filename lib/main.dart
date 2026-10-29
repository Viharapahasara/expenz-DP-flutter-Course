import 'package:expenz/screen/onboard/widget/wrapper.dart';
import 'package:expenz/services/app_theme_service.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppThemeService.instance.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: UserService.checkUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final bool hasUserName = snapshot.data ?? false;
        return AnimatedBuilder(
          animation: AppThemeService.instance,
          builder: (context, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: AppThemeService.instance.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF7F3DFF),
                brightness: Brightness.light,
              ),
              fontFamily: 'Inter',
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF7F3DFF),
                brightness: Brightness.dark,
              ),
              fontFamily: 'Inter',
            ),
            home: Wrapper(showMAinScreen: hasUserName),
          ),
        );
      },
    );
  }
}