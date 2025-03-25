class SheetsColumn {
  static final primaryTransport = "Primary mode of transportation";
  static final hybridVehicle = "Do you own an electric or hybrid vehicle";
  static final frequency = "Frequency of using private transportation";
  static final drivingPattern = "Driving pattern";
  static final distance = "Average distance traveled per day (in kilometers)";
  static final carpool = "Do you carpool or share rides";

  static List<String> getColumns() => [
        primaryTransport,
        hybridVehicle,
        frequency,
        drivingPattern,
        distance,
        carpool,
      ];
}
