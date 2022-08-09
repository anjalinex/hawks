import 'package:intl/intl.dart';

class CustomFormValidation {
  static String? empty(String? data) {
    if (data!.isEmpty) {
      return "Please fill or select item";
    }
  }

  static String? date(String? data) {
    if (data!.isEmpty) {
      return "Please select date";
    }
    try {
      DateTime date = DateFormat('dd MMM, yyyy').parse(data);
    } catch (e) {
      return "Please enter valid date";
    }
  }

  static String? name(String? data) {
    if (data!.isEmpty) {
      return "Please enter name";
    }

    if (!RegExp('[a-zA-Z]').hasMatch(data)) {
      return "Please enter valid name";
    }
  }

  static String? mobile(String? data) {
    if (data!.isEmpty) {
      return "Please enter mobile number";
    }

    if (data.length < 8 || data.length > 12) {
      return "Please enter number with length between 8-12";
    }
    if (!RegExp('[0-9]').hasMatch(data)) {
      return "Please enter valid number";
    }
  }

  static String? otp(String? data) {
    if (data!.isEmpty) {
      return "Please enter otp";
    }

    if (data.length != 6) {
      return "Please enter otp with length 6";
    }
    if (!RegExp('[0-9]').hasMatch(data)) {
      return "Please enter valid otp";
    }
  }

  static String? email(String? data) {
    if (data!.isEmpty) {
      return "Please enter email";
    }

    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(data)) {
      return "Please enter valid email";
    }
  }

  static String? password(String? data) {
    if (data!.isEmpty) {
      return "Please enter password";
    }

    if (data.length < 6) {
      return "Please enter password more than 6 length";
    }
  }
}
