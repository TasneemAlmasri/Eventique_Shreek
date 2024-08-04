import '/providers/statics_provider.dart';
import '/providers/orders.dart';
import '/providers/reviews.dart';
import '/providers/services_list.dart';
import '/screens/navigation_bar_page.dart';
import '/screens/email_rest_screen.dart';
import '/screens/password_rest_screen.dart';
import '/screens/vendor_profile_screen.dart';
import '/screens/verification_screen.dart';
import '/providers/theme_provider.dart';
import '/providers/users_provider.dart';
import '/screens/chat_screen.dart';
import '/screens/enter_email_screen.dart';
import '/screens/forget_password_screen.dart';
import '/screens/login_screen.dart';
import '/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import '/providers/auth_vendor.dart';
import '/providers/event_provider.dart';
import '/providers/services_provider.dart';
import '/screens/sign_up_screens/sign_up_screen1.dart';
import '/screens/sign_up_screens/sign_up_screen2.dart';
import '/screens/sign_up_screens/sign_up_screen3.dart';
import '/screens/sign_up_screens/sign_up_screen4.dart';

String host = 'http://192.168.1.104:8000';
// String host = 'http://127.0.0.1:8000';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authProvider = AuthVendor();
  await authProvider.loadUserData();

  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: MyApp(authProvider: authProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthVendor authProvider;

  MyApp({super.key, AuthVendor? authProvider})
      : authProvider = authProvider ?? AuthVendor();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final token = authProvider.token;
    final id = authProvider.userId;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ThemeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: authProvider,
        ),
        ChangeNotifierProvider.value(
          value: ServiceProvider(token, id),
        ),
        ChangeNotifierProvider.value(
          value: EventProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UsersProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(token,id),
        ),
        ChangeNotifierProvider.value(
          value: AllServices(id, token),
        ),
        ChangeNotifierProvider.value(
          value: Reviews(token),
        ),
        ChangeNotifierProvider.value(
          value: StatisticsProvider(
            token,
            id,
          ),
        )
      ],
      child: Consumer<AuthVendor>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'EvenTique shreek',
          themeMode: themeProvider.getThemeMode(),
          home: auth.isAuthenticated ? NavigationBarPage() : LoginScreen(),
          //home: NavigationBarPage(),
          debugShowCheckedModeBanner: false,
          routes: {
            SignUpScreen1.routeName: (ctx) => SignUpScreen1(),
            SignUpScreen2.routeName: (ctx) => SignUpScreen2(),
            SignUpScreen3.routeName: (ctx) => SignUpScreen3(),
            SignUpScreen4.routeName: (ctx) => SignUpScreen4(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            EnterEmailScreen.routeName: (ctx) => EnterEmailScreen(),
            NewPasswordScreen.routeName: (ctx) => NewPasswordScreen(),
            EmailRestScreen.routeName: (ctx) => EmailRestScreen(),
            PasswordRestScreen.routeName: (ctx) => PasswordRestScreen(),
            VendorProfileScreen.routeName: (ctx) => VendorProfileScreen(),
            VerificationScreen.routeName: (ctx) => VerificationScreen(),
            ChatScreen.routeName: (ctx) => ChatScreen(),
            UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
            NavigationBarPage.routeName: (ctx) => NavigationBarPage(),
          },
        ),
      ),
    );
  }
}
