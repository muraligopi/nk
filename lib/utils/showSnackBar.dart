import 'package:Nkipay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Text(
          text,
        ),
      ),
    ),
  );
}
