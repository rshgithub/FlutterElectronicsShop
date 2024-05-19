
import '../views/auth/screens/authentaication/signup_screen.dart';
import '../views/auth/screens/authentaication/login_screen.dart';

class RoteNames {
  static String loginRouteName = 'login';
  static String registerRouteName = 'register';

  static getRoutes() {
    return {
      loginRouteName: (context) => LoginScreen(),
      registerRouteName: (context) => SignUpScreen(),
    };
  }
}
