import 'package:get_storage/get_storage.dart';
import '../utils/storage_keys.dart';

class StorageService {
  static final session = GetStorage();
  static dynamic userSession = session.read(StorageKeys.userSession);
}
