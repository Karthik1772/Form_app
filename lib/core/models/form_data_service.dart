class FormDataService {
  static final FormDataService _instance = FormDataService._internal();

  FormDataService._internal();

  static FormDataService get instance => _instance;

  final Map<String, String> _formData = {};
  void saveData(Map<String, String> data) {
    _formData.addAll(data);
  }

  Map<String, String> getData() {
    return _formData;
  }

  void clearData() {
    _formData.clear();
  }
}
