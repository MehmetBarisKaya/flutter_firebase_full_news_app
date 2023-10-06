// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    required this.subTitle,
    super.key,
    this.color,
  });
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: context.general.textTheme.titleMedium?.copyWith(
        color: color,
      ),
    );
  }
}
