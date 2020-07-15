import 'package:flutter/material.dart';

class Config {
  static final String cctvUrl = "http://192.168.0.4:5556/rfids";
  static final String rfidUrl = "http://192.168.0.4:5556/rfids";
  static final String mobileDeviceId = "826bead5-7b6b-4895-8b7e-9671f0928f7f";
}

class DBConfig {
  DB database;
  ApiConfig configs;

  DBConfig(this.database) {
    switch (this.database) {
      case DB.BoxlandDevDB:
        configs = ApiConfig(
          posRestApi: "http://p2posrestapiv2.retail-sys.com/",
          licenseCode: "LicenseForBoxland_DevDB_RESTAPIV2",
        );
        break;
      case DB.Service01:
        configs = ApiConfig(
          posRestApi: "http://service01.p2posrestapiv2.retail-sys.com/",
          licenseCode: "LicenseForBoxland_P2Pos_RESTAPIV2",
        );
        break;
      case DB.JCAL:
        configs = ApiConfig(
          posRestApi: "http://p2posrestapiv2-web01.t2ms.com/",
          licenseCode: "LicenseForJCAL_P2Pos_RESTAPIV2",
        );
        break;
    }
  }
}

class ApiConfig {
  String posRestApi;
  String licenseCode;
  String imagePath;
  String token;

  ApiConfig({
    this.imagePath = "",
    this.token,
    @required this.posRestApi,
    @required this.licenseCode,
  });
}

enum DB { BoxlandDevDB, Service01, JCAL }
