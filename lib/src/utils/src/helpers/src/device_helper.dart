import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class DeviceHelper {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  static Future<String> platformName() async {
    String deviceName = "random_${generateRandomString(5)}";

    try {
      if (kIsWeb) {
        deviceName = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            deviceName =
                _readAndroidBuildData(await deviceInfoPlugin.androidInfo) ??
                    deviceName;
            break;
          case TargetPlatform.iOS:
            deviceName = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo) ??
                deviceName;
            // return ios;
            break;
          case TargetPlatform.macOS:
            deviceName = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
            // return macos;
            break;
          case TargetPlatform.windows:
            deviceName =
                _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
            break;
          case TargetPlatform.linux:
            deviceName = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);

            break;
          default:
            break;
        }
      }
    } on PlatformException {
      deviceName = generateRandomString(5);
    }

    return deviceName;
  }

  static String? _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.device;
    // return <String, dynamic>{
    //   'version.securityPatch': build.version.securityPatch,
    //   'version.sdkInt': build.version.sdkInt,
    //   'version.release': build.version.release,
    //   'version.previewSdkInt': build.version.previewSdkInt,
    //   'version.incremental': build.version.incremental,
    //   'version.codename': build.version.codename,
    //   'version.baseOS': build.version.baseOS,
    //   'board': build.board,
    //   'bootloader': build.bootloader,
    //   'brand': build.brand,
    //   'device': build.device,
    //   'display': build.display,
    //   'fingerprint': build.fingerprint,
    //   'hardware': build.hardware,
    //   'host': build.host,
    //   'id': build.id,
    //   'manufacturer': build.manufacturer,
    //   'model': build.model,
    //   'product': build.product,
    //   'supported32BitAbis': build.supported32BitAbis,
    //   'supported64BitAbis': build.supported64BitAbis,
    //   'supportedAbis': build.supportedAbis,
    //   'tags': build.tags,
    //   'type': build.type,
    //   'isPhysicalDevice': build.isPhysicalDevice,
    //   'systemFeatures': build.systemFeatures,
    // };
  }

  static String? _readIosDeviceInfo(IosDeviceInfo data) {
    return data.name;

    // return <String, dynamic>{
    //   'name': data.name,
    //   'systemName': data.systemName,
    //   'systemVersion': data.systemVersion,
    //   'model': data.model,
    //   'localizedModel': data.localizedModel,
    //   'identifierForVendor': data.identifierForVendor,
    //   'isPhysicalDevice': data.isPhysicalDevice,
    //   'utsname.sysname:': data.utsname.sysname,
    //   'utsname.nodename:': data.utsname.nodename,
    //   'utsname.release:': data.utsname.release,
    //   'utsname.version:': data.utsname.version,
    //   'utsname.machine:': data.utsname.machine,
    // };
  }

  static String _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return data.name;
    // return <String, dynamic>{
    //   'name': data.name,
    //   'version': data.version,
    //   'id': data.id,
    //   'idLike': data.idLike,
    //   'versionCodename': data.versionCodename,
    //   'versionId': data.versionId,
    //   'prettyName': data.prettyName,
    //   'buildId': data.buildId,
    //   'variant': data.variant,
    //   'variantId': data.variantId,
    //   'machineId': data.machineId,
    // };
  }

  static String _readWebBrowserInfo(WebBrowserInfo data) {
    return describeEnum(data.browserName);
    // return <String, dynamic>{
    //   'browserName': describeEnum(data.browserName),
    //   'appCodeName': data.appCodeName,
    //   'appName': data.appName,
    //   'appVersion': data.appVersion,
    //   'deviceMemory': data.deviceMemory,
    //   'language': data.language,
    //   'languages': data.languages,
    //   'platform': data.platform,
    //   'product': data.product,
    //   'productSub': data.productSub,
    //   'userAgent': data.userAgent,
    //   'vendor': data.vendor,
    //   'vendorSub': data.vendorSub,
    //   'hardwareConcurrency': data.hardwareConcurrency,
    //   'maxTouchPoints': data.maxTouchPoints,
    // };
  }

  static String _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return data.computerName;
    // return <String, dynamic>{
    //   'computerName': data.computerName,
    //   'hostName': data.hostName,
    //   'arch': data.arch,
    //   'model': data.model,
    //   'kernelVersion': data.kernelVersion,
    //   'osRelease': data.osRelease,
    //   'activeCPUs': data.activeCPUs,
    //   'memorySize': data.memorySize,
    //   'cpuFrequency': data.cpuFrequency,
    //   'systemGUID': data.systemGUID,
    // };
  }

  static String _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return data.computerName;
    // return <String, dynamic>{
    //   'numberOfCores': data.numberOfCores,
    //   'computerName': data.computerName,
    //   'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
    //   'userName': data.userName,
    //   'majorVersion': data.majorVersion,
    //   'minorVersion': data.minorVersion,
    //   'buildNumber': data.buildNumber,
    //   'platformId': data.platformId,
    //   'csdVersion': data.csdVersion,
    //   'servicePackMajor': data.servicePackMajor,
    //   'servicePackMinor': data.servicePackMinor,
    //   'suitMask': data.suitMask,
    //   'productType': data.productType,
    //   'reserved': data.reserved,
    //   'buildLab': data.buildLab,
    //   'buildLabEx': data.buildLabEx,
    //   'digitalProductId': data.digitalProductId,
    //   'displayVersion': data.displayVersion,
    //   'editionId': data.editionId,
    //   'installDate': data.installDate,
    //   'productId': data.productId,
    //   'productName': data.productName,
    //   'registeredOwner': data.registeredOwner,
    //   'releaseId': data.releaseId,
    //   'deviceId': data.deviceId,
    // };
  }
}
