import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Divider(
        thickness: 1,
        color: Colors.grey.withOpacity(0.4),
      ),
    );
  }
}
