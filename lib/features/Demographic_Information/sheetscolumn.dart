class SheetsColumn {
  static const name = "Name";
  static const email = "Email";
  static const age = "Age";
  static const gender = "Gender";
  static const location = "Location";
  static const occupation = "Occupation";

  static List<String> getColumns() => [
        name,
        email,
        age,
        gender,
        location,
        occupation,
      ];
}
