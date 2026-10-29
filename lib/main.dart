import 'package:expenz/screen/onboard/widget/wrapper.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<bool> _startupFuture = _initializeApp();

  Future<bool> _initializeApp() async {
    try {
      return await UserService.checkUserName();
    } catch (error, stackTrace) {
      debugPrint('App startup preferences failed: $error\n$stackTrace');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _startupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final bool hasUserName = snapshot.data ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Inter',
          ),
          home: Wrapper(showMAinScreen: hasUserName),
        );
      },
    );
  }
}
