class SheetsColumn {
  static final primary = "Primary mode of transportation";
  static final hybrid = "Do you own an electric or hybrid vehicle";
  static final frequency = "Frequency of using private transportation";
  static final pattern = "Driving pattern";
  static final distance = "Average distance traveled per day (in kilometers)";
  static final pool = "Do you carpool or share rides";

  static List<String> getColumns() => [
        primary,
        hybrid,
        frequency,
        pattern,
        distance,
        pool,
      ];
}
