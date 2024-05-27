import 'package:pocket_swap_fisi/domain/services/websocket_service.dart';

final class WebsocketUseCase {
  final WebsocketService _websocketService;

  static final WebsocketUseCase _instance = WebsocketUseCase._(WebsocketService());

  WebsocketUseCase._(this._websocketService);

  static WebsocketUseCase get instance => _instance;

  void initializeSocketConnection() {
    _websocketService.initializeSocketConnection();
  }

  void disconnectFromSocket() {
    _websocketService.disconnectFromSocket();
  }

  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    _websocketService.webSocketReceiver(eventName, onEvent);
  }

  void webSocketSender(String eventName, dynamic body) {
    _websocketService.webSocketSender(eventName, body);
  }
}
