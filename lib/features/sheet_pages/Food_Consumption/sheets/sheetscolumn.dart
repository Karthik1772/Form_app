class SheetsColumn {
  static final diet = "Type of diet consumed";
  static final beef = "How much beef do you consume per week(in kgs)";
  static final pork = "How much pork do you consume per week(in kgs)";
  static final mutton = "How much mutton do you consume per week(in kgs)";
  static final milk = "How much milk do you consume per week(in kgs)";
  static final potato = "How much potato do you consume per week(in kgs)";
  static final vegetables = "How much vegetables do you consume per week(in kgs)";
  static final rice = "How much rice do you consume per week(in kgs)";
  static final wheat = "How much wheat do you consume per week(in kgs)";
  static final nuts = "How much nuts do you consume per week(in kgs)";

  static List<String> getColumns() => [
    diet,
    beef,
    pork,
    mutton,
    milk,
    potato,
    vegetables,
    rice,
    wheat,
    nuts,
  ];
}
