class Validation {
  String validateWhiteSpace(String value) {
    if (value == null || value.isEmpty) {
      return 'This is required field';
    }
    return null;
  }

  String validateEmail(String email) {
    var pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    if (email == null || email.isEmpty) {
      return 'This is required field';
    }
    if (!RegExp(pattern).hasMatch(email)) {
      return 'Invalid email.';
    }
    return null;
  }

  String validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return 'This is required field';
    }
    if (password.length < 6) {
      return 'Passwords must be at least 6 characters';
    }
    return null;
  }

  String validateCapacityTruck(String weight) {
    if (weight == null || weight.isEmpty) {
      return 'This is required field';
    }
    if (int.tryParse(weight) == null) {
      return 'Truck capacity must be integer';
    }
    if (int.parse(weight) < 0) {
      return 'Truck capacity must be greater than 0';
    }
    return null;
  }

  String validateCostTruck(String cost) {
    if (cost == null || cost.isEmpty) {
      return 'This is required field';
    }
    if (int.tryParse(cost) == null) {
      return 'Truck cost must be integer';
    }
    if (int.parse(cost) < 0) {
      return 'Truck cost must be greater than 0';
    }
    return null;
  }
}
