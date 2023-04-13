import 'package:flutter/material.dart';

class ProgramWidgets extends StatelessWidget {
  final title;
  final img;
  const ProgramWidgets({
    Key? key,
    required this.title,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Image.network(
                  img,
                  height: 60,
                )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "SanFranciscos",
                      fontSize: 25,
                    )))
          ],
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
