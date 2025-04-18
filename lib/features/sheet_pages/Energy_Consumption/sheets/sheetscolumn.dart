class SheetsColumn {
  static final power = "Primary source of energy for your home";
  static final energy =
      "Do you use energy efficient appliances and light bulbs";
  static final month = "Average monthly electricity consumption(in KWh)";

  static List<String> getColumns() => [power, energy, month];
}
