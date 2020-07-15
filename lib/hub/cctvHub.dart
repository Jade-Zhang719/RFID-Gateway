import '../config/config.dart';
import 'hub.dart';

class CCTVHub extends HubService {
  CCTVHub() : super(Config.cctvUrl);

  Future captureImage(String sku, String rfidId) async {
    Map data = {
      "mobileDeviceId": Config.mobileDeviceId,
      "rfidId": rfidId,
      "sku": sku,
    };
    return await super.invoke("ImageCapture", [data]);
  }

  Future captureVideo(String sku, String rfidId) async {
    Map data = {
      "mobileDeviceId": Config.mobileDeviceId,
      "rfidId": rfidId,
      "sku": sku,
      "startTime": DateTime.now().subtract(Duration(seconds: 15)).toString(),
      "endTime": DateTime.now().add(Duration(seconds: 45)).toString()
    };
    return await super.invoke("VideoUpload", [data]);
  }
}
