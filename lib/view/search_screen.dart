import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view_model/get_user.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import 'components/card_tiles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static final User? user = FirebaseAuth.instance.currentUser;
  static final TextEditingController searchCtrl =
      TextEditingController(text: '');

  Future<void> getData(BuildContext context) async {
    var provider = Provider.of<GetUser>(context, listen: false);
    return provider.searchUser('');
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetUser>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: kHeadingOne,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: kScreenSpan),
          children: [
            TextField(
              controller: searchCtrl,
              decoration: const InputDecoration(
                hintText: 'Type some word...',
              ),
              onChanged: (value) {
                provider.searchUser(searchCtrl.text);
              },
            ),
            SizedBox(height: 20),
            Consumer<GetUser>(
              builder: (context, users, child) {
                var user = users.searchResult;
                if (user.isEmpty) {
                  return Column(
                    children: [
                      Lottie.asset('assets/empty.json'),
                      Text(
                        users.message,
                        style: kHeadingOne,
                      )
                    ],
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: user.length,
                  itemBuilder: (context, i) => ZoomIn(
                    delay: Duration(milliseconds: i * 20),
                    child: CardList(
                      title: user[i].fullname,
                      trailing: user[i].email,
                      subtitle: user[i].phone,
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}
