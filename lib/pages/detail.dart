import 'package:apod/repository/repository.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.apod});

  final Apod apod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astronomy Picture of the Day'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(apod.date),
            Image.network(apod.url),
            Text(apod.title),
            Text(apod.explanation),
          ],
        ),
      ),
    );
  }
}
