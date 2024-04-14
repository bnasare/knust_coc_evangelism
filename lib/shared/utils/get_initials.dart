 class Initials {
  static String getUserInitials(String firstName, String lastName) {
    // Ensure that both first name and last name are not empty
    if (firstName.isEmpty && lastName.isEmpty) {
      return '';
    }

    // Get the first letter of the first name
    String firstInitial = firstName.isNotEmpty ? firstName[0] : '';

    // Get the first letter of the last name
    String lastInitial = lastName.isNotEmpty ? lastName[0] : '';

    // Concatenate the first initials
    return '$firstInitial$lastInitial';
  }
}