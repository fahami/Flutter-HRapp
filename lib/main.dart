import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view/create_role_screen.dart';
import 'package:hrapp/view/home.dart';
import 'package:hrapp/view/login.dart';
import 'package:hrapp/view/onboard.dart';
import 'package:hrapp/view/search_screen.dart';
import 'package:hrapp/view_model/get_role.dart';
import 'package:hrapp/view_model/get_user.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HRApp());
}

class HRApp extends StatefulWidget {
  const HRApp({Key? key}) : super(key: key);

  @override
  State<HRApp> createState() => _HRAppState();
}

class _HRAppState extends State<HRApp> {
  String _initialRoute = '/';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: Check initial route
    super.initState();
    _initialRoute = user != null ? '/' : '/onboard';
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetRole(),
        ),
      ],
      child: GetMaterialApp(
        theme: hrTheme,
        themeMode: ThemeMode.light,
        title: 'HR App',
        initialRoute: _initialRoute,
        getPages: [
          GetPage(name: '/', page: () => const HomeScreen()),
          GetPage(name: '/login', page: () => const Login()),
          GetPage(name: '/search', page: () => const SearchScreen()),
          GetPage(name: '/onboard', page: () => const OnBoarding()),
          GetPage(name: '/create_role', page: () => CreateRoleScreen()),
        ],
      ),
    );
  }
}
