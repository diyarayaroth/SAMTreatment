mixin ValidationMixin {
  String? zipCodeValidation(String? zipcode) {
    if (zipcode!.isNotEmpty) {
      if (zipcode.length != 5) {
        return "Please enter 5 digit zip code";
      }
      return null;
    } else {
      return "Please Enter Zip Code";
    }
  }
}
