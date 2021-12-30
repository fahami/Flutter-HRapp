import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view/components/snackbars.dart';
import 'package:hrapp/view_model/get_role.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> getData(BuildContext context) async {
    var provider = Provider.of<GetRole>(context, listen: false);
    await provider.fetchRoles();
  }

  User? user = FirebaseAuth.instance.currentUser;

  final formatDate = DateFormat.yMMMEd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user!.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kScreenSpan,
              vertical: 20,
            ),
            child: Text(
              'Profile',
              style: kHeadingOne,
            ),
          ),
          user!.photoURL == null
              ? Container()
              : Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user!.photoURL!,
                    ),
                    backgroundColor: colorAccent,
                    maxRadius: 80,
                  ),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                user!.displayName == null
                    ? Container()
                    : ListTile(
                        leading: const Icon(Icons.perm_identity),
                        title: Text(
                          'Name',
                          style: kHeadingFour,
                        ),
                        subtitle: Text(
                          user!.displayName!,
                          style: kHeadingFour.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: Text(
                    'Email',
                    style: kHeadingFour,
                  ),
                  subtitle: Text(
                    user!.email!,
                    style: kHeadingFour.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.app_registration_outlined),
                  title: Text(
                    'Register date',
                    style: kHeadingFour,
                  ),
                  subtitle: Text(
                    formatDate.format(user!.metadata.creationTime!),
                    style: kHeadingFour.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: Text(
                    'Last login',
                    style: kHeadingFour,
                  ),
                  subtitle: Text(
                    formatDate.format(user!.metadata.lastSignInTime!),
                    style: kHeadingFour.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () async => await FirebaseAuth.instance
                .signOut()
                .onError((error, _) => showSnackbar(context, error.toString()))
                .then((_) => showSnackbar(context, 'Sign out successfully'))
                .then((_) => Get.offNamedUntil('/onboard', (route) => false)),
            child: Text(
              'Sign out',
              style: kHeadingFour,
            ),
          )
        ],
      ),
    );
  }
}
