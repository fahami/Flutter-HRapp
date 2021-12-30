import 'package:flutter/material.dart';
import 'package:hrapp/res/constant.dart';

class CardList extends StatelessWidget {
  const CardList({
    Key? key,
    this.title,
    this.trailing,
    this.subtitle,
  }) : super(key: key);

  final String? title;
  final String? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorAccent,
          child: Text(
            title != null
                ? title!.length >= 2
                    ? title!.substring(0, 2).toUpperCase()
                    : title!
                : '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(title ?? 'Role'),
        subtitle: Text(subtitle ?? 'Description'),
        trailing: Text(trailing ?? 'Requirement'),
      ),
    );
  }
}
