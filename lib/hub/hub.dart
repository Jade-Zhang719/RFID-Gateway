import 'package:signalr_client/signalr_client.dart';

import '../config/config.dart';

class HubService {
  final String serverUrl;

  HubConnection _hubConnection;

  HubService(this.serverUrl) {
    _hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

    _hubConnection
        .onclose((error) => print("${this.serverUrl} Connection Closed"));
  }

  Future<void> connect() async {
    if (this._hubConnection.state == HubConnectionState.Disconnected)
      return this._hubConnection.start();
  }

  Future<void> disconnect() async {
    if (this._hubConnection.state == HubConnectionState.Connected)
      return this._hubConnection.stop();
  }

  HubConnectionState getConnectionState() {
    return this._hubConnection.state;
  }

  Future<void> associateMobileDevice() async {
    await this._hubConnection.invoke("APPsConnectWS",
        args: <Object>[Config.mobileDeviceId, "license"]);
  }

  void trayListener(Function(List<Object>) callback) {
    return this._hubConnection.on("TrayInfo", callback);
  }

  Future<Object> invoke(String methodName, List<Object> arguments) async {
    return await this._hubConnection.invoke(methodName, args: arguments);
  }

  Stream<Object> stream(String methodName, List<Object> arguments) {
    return this._hubConnection.stream(methodName, arguments);
  }
}
