class HubData {
  final String mobileDeviceId;
  final String rfidId;
  final String sku;
  final String startTime;
  final String endTime;

  HubData({
    this.mobileDeviceId,
    this.rfidId,
    this.sku,
    this.endTime,
    this.startTime,
  });

  factory HubData.fromJson(Map<String, dynamic> json) {
    return HubData(
      mobileDeviceId: json["mobileDeviceId"],
      rfidId: json["rfidId"],
      sku: json["sku"],
      startTime: json["startTime"],
      endTime: json["endTime"],
    );
  }
}
