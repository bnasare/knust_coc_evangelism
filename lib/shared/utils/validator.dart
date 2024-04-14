import 'package:intl/intl.dart';

class Validator {
  static String? phone(String? value) {
    String cleanedValue = value!.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanedValue.isEmpty) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // static String? phone(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a valid phone number';
  //   }
  //   bool isValid = RegExp(r'^\+?\d*$').hasMatch(value);
  //   if (!isValid) {
  //     return 'Invalid character in phone number, only + and numbers are allowed';
  //   }
  //   return null;
  // }

  static String? otp(String? value) {
    String cleanedValue = value!.replaceAll(RegExp(r'[^\d]'), '');
    if (value.isEmpty) {
      return 'Please enter OTP code';
    }
    if (cleanedValue.length < 6) {
      return 'Please enter 6-digit OTP code';
    }
    return null;
  }

  static String? firstName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your first name';
    }
    if (!RegExp(r"^[a-zA-Z'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? lastName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your last name';
    }
    if (!RegExp(r"^[a-zA-Z'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? title(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your title';
    }
    if (!RegExp(r"^[a-zA-Z'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid title';
    }
    return null;
  }

  static String? address(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your address';
    }
    if (!RegExp(r"^[a-zA-Z0-9'\- ]+$").hasMatch(value)) {
      return 'Please enter a valid address';
    }
    return null;
  }

  static String? email(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email address';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? dob(String? value) {
    if (value!.isEmpty) {
      return 'Please choose your date of birth';
    }
    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
      return 'Please enter a valid date of birth';
    }
    final selectedDate = DateFormat('dd/MM/yyyy').parseStrict(value);
    if (selectedDate.isAfter(DateTime(DateTime.now().year - 18))) {
      return 'You need to be 18 years to continue';
    }
    return null;
  }

  static String? country(String? value) {
    if (value == null) return 'Please select a country';
    if (value.isEmpty) return 'Please select a country';
    return null;
  }

  static String? dropDown(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field cannot be empty';
    }
    return null;
  }
}
