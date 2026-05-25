import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontStyles {
  static final TextStyle _regular = GoogleFonts.plusJakartaSans();
  static final TextStyle _bold = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w800,
  );

  static TextStyle regularHeader1 = _regular.copyWith(
    fontSize: 36,
    color: Colors.white,
  );
  static TextStyle regularHeader2 = _regular.copyWith(
    fontSize: 20,
    color: Colors.white,
  );
  static TextStyle regularBody1 = _regular.copyWith(
    fontSize: 16,
    color: Colors.white,
  );
  static TextStyle regularBody2 = _regular.copyWith(
    fontSize: 12,
    color: Colors.white,
  );
  static TextStyle regularSubtitle = _regular.copyWith(
    fontSize: 10,
    color: Colors.white,
  );

  static TextStyle boldHeader1 = _bold.copyWith(
    fontSize: 36,
    color: Colors.white,
  );
  static TextStyle boldHeader2 = _bold.copyWith(
    fontSize: 20,
    color: Colors.white,
  );
  static TextStyle boldBody1 = _bold.copyWith(
    fontSize: 16,
    color: Colors.white,
  );
  static TextStyle boldBody2 = _bold.copyWith(
    fontSize: 12,
    color: Colors.white,
  );
  static TextStyle boldSubtitle = _bold.copyWith(
    fontSize: 10,
    color: Colors.white,
  );
}
