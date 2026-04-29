import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  var isConnected = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _check());
    _check();
  }

  Future<void> _check() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 4));
      final connected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (connected != isConnected.value) {
        isConnected.value = connected;
        if (!connected) {
          Get.snackbar(
            'No Internet',
            'Please check your connection.',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(days: 1),
            isDismissible: false,
          );
        } else {
          if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
          Get.snackbar('Back Online', 'Connection restored.',
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2));
        }
      }
    } catch (_) {
      if (isConnected.value) {
        isConnected.value = false;
        Get.snackbar(
          'No Internet',
          'Please check your connection.',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(days: 1),
          isDismissible: false,
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
