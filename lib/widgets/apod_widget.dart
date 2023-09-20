import 'package:flutter/material.dart';

class ApodWidget extends StatelessWidget {
  const ApodWidget({
    super.key,
    required this.title,
    required this.date,
    this.onTap,
  });

  final String title;
  final String date;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: Text(date),
    );
  }
}
