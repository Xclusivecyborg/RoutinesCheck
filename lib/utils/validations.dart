class Validators {
  static Validator notEmpty() {
    return (String? value) {
      return (value?.isEmpty ?? true) ? "This field can not be empty." : null;
    };
  }
}

typedef Validator = String? Function(String? value);
