import 'package:flutter/material.dart';

import '../../../../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child:
              SizedBox(
                width: 200.0,
                height: 300.0,
                child: Image.asset("assets/images/login.png"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}