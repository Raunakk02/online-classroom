import 'package:dapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dapp/utils/globals.dart';
import 'package:google_fonts/google_fonts.dart';

extension AsyncGlobal<T> on AsyncValue {
  Widget globalWhen({required Widget Function(T? data) data}) {
    return when<Widget>(
      data: (_) => data(_),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: ColorsUtils.kPrimaryColor,
        ),
      ),
      error: (err, __) {
        String text = "SOME ERR OCCURRED";
        if (err is String)
          text = err;
        else if (err is Exception) text = err.toString();
        return Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(fontSize: 4.w),
          ),
        );
      },
    );
  }
}
