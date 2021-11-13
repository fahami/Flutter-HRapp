import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view_model/get_role.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'components/card_tiles.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({Key? key}) : super(key: key);

  Future<void> getData(BuildContext context) async {
    var provider = Provider.of<GetRole>(context, listen: false);
    await provider.fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorAccent,
          onPressed: () => Get.toNamed('/create_role'),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kScreenSpan,
                vertical: 20,
              ),
              child: Text(
                'Role List',
                style: kHeadingOne,
              ),
            ),
            FutureBuilder(
              future: getData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(child: Consumer<GetRole>(
                    builder: (context, value, child) {
                      var role = value.result;
                      return RefreshIndicator(
                        onRefresh: () => getData(context),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.symmetric(horizontal: kScreenSpan),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: role.length,
                          itemBuilder: (context, i) {
                            return ZoomIn(
                              delay: Duration(milliseconds: i * 20),
                              child: CardList(
                                title: role[i].title,
                                subtitle: role[i].description,
                                trailing: role[i].requirement,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Lottie.asset('assets/load.json');
                }
                return const Center(
                    child: Text('Maaf sistem sedang bermasalah'));
              },
            )
          ],
        ));
  }
}
