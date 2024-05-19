import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/app_routers/app_routers.dart';
import 'package:ft_e_buy/providers/auth_provider.dart';
import 'package:ft_e_buy/views/auth/screens/Splash/splash_screen.dart';
import 'package:ft_e_buy/views/auth/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import 'admin/providers/admin_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle( statusBarColor: AppColors.lightBrown,));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.navKey,
        home:  SplashScreen(),
      ),
    );
  }
}
