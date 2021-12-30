import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view_model/get_user.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'components/card_tiles.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  Future<void> getData(BuildContext context) async {
    var provider = Provider.of<GetUser>(context, listen: false);
    await provider.fetchUsers();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User List',
                style: kHeadingOne,
              ),
              IconButton(
                onPressed: () => Get.toNamed('/search'),
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Expanded(child: Consumer<GetUser>(
                builder: (context, value, child) {
                  var user = value.result;
                  return RefreshIndicator(
                    onRefresh: () => getData(context),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: kScreenSpan),
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
                    ),
                  );
                },
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset('assets/load.json');
            }
            return const Center(child: Text('Maaf sistem sedang bermasalah'));
          },
        )
      ],
    ));
  }
}
