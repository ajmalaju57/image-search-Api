import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewImage extends StatefulWidget {
  String? image;
  ViewImage({Key? key, this.image}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image.toString()),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
