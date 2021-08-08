import 'package:get/get.dart';

class Navigation {
  static intent(String routeName, Object? arguments) {
    Get.toNamed(routeName, arguments: arguments);
  }

  static replacementIntent(String routeName, Object? arguments) {
    Get.offNamed(routeName, arguments: arguments);
  }

  static replacementAllIntent(String routeName, Object? arguments) {
    Get.offAllNamed(routeName, arguments: arguments);
  }

  static back() => Get.back();
}
