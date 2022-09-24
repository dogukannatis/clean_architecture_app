
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try{
    if(Platform.isAndroid){
      var build = await deviceInfo.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = "${build.id}";
      version = "${build.version.codename}";
    }else if(Platform.isIOS){
      var build = await deviceInfo.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = "${build.identifierForVendor}";
      version = "${build.systemVersion}";
    }
  } on PlatformException {
    return DeviceInfo(name,identifier,version);
  }

  return DeviceInfo(name,identifier,version);



}