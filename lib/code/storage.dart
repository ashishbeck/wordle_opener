import 'package:get_storage/get_storage.dart';

StorageService storageService = StorageService();

class StorageService {
  var box = GetStorage();
  bool? darkMode;
  bool? seenHelp;

  init() {
    darkMode = box.read("darkMode");
    seenHelp = box.read("seenHelp");
  }

  toggleDarkMode(bool value) {
    darkMode = value;
    box.write("darkMode", value);
  }

  updateSeenHelp() {
    seenHelp = true;
    box.write("seenHelp", true);
  }
}
