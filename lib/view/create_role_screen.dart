import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/view/components/snackbars.dart';
import 'package:hrapp/view_model/get_role.dart';
import 'package:provider/provider.dart';

class CreateRoleScreen extends StatelessWidget {
  CreateRoleScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController requirementController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetRole>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Role',
          style: kHeadingOne,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kScreenSpan),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Wrap(
                          runSpacing: 10,
                          children: [
                            Text(
                              'Name',
                              style: kHeadingThree,
                            ),
                            TextFormField(
                              autofocus: true,
                              controller: titleController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                hintText: "Role name",
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) =>
                                  value!.isEmpty ? 'Insert name of role' : null,
                            ),
                            Text(
                              'Description',
                              style: kHeadingThree,
                            ),
                            TextFormField(
                              controller: descController,
                              maxLines: 8,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                hintText: "Role Description",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Insert description' : null,
                            ),
                            Text(
                              'Requirement',
                              style: kHeadingThree,
                            ),
                            TextFormField(
                              controller: requirementController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Requirement of role"),
                              validator: (value) =>
                                  value!.isEmpty ? 'Insert requirement' : null,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.all(kScreenSpan),
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider
                        .createRole(titleController.text, descController.text,
                            requirementController.text)
                        .then((_) =>
                            showSnackbar(context, 'Role baru telah dibuat'))
                        .then((_) => Get.offNamed('/'));
                  }
                },
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: colorAccent)),
                child: Text(
                  'Save',
                  style: kHeadingThree.copyWith(color: colorAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
