import 'package:flutter/material.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view/profile_screen.dart';
import 'package:hrapp/view/role_screen.dart';
import 'package:hrapp/view/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: IndexedStack(children: screens, index: currIndex)),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: BottomNavigationBar(
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            backgroundColor: colorAccent,
            unselectedItemColor: Colors.white70,
            currentIndex: currIndex,
            onTap: (index) => setState(() => currIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.engineering),
                label: "Role",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_ind),
                label: "Users",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      ),
    );
  }

  List<Widget> screens = [
    const RoleScreen(),
    const UserScreen(),
    ProfileScreen(),
  ];
}
