import '../config/config.dart';
import 'hub.dart';

class RFIDHub extends HubService {
  RFIDHub() : super(Config.rfidUrl);

  Stream<Object> streamProducts() {
    return super.stream("StreamFilterTags", []);
  }
}
