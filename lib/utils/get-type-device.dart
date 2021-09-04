import 'package:zikroulah/utils/type-device.dart';

DeviceType getDeviceType(double width) =>
    width > 800 ? DeviceType.LATOP : DeviceType.PHONE;
