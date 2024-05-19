import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String? name;
  Icon? icon;
  BuildContext? context;
  void Function()? onPressed;


  UserInfo(this.name, this.icon, this.context, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            side: const BorderSide(
              width: 0.0,
              color: Colors.transparent,
              style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                icon!,
// Icon(Icons.circle,color: Colors.grey, size: 12.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF393939),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}