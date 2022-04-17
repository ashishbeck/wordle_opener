import 'package:get_storage/get_storage.dart';

StorageService storageService = StorageService();

class StorageService {
  var box = GetStorage();
  bool? darkMode;

  init() {
    darkMode = box.read("darkMode");
  }

  toggleDarkMode(bool value) {
    darkMode = value;
    box.write("darkMode", value);
  }
}
