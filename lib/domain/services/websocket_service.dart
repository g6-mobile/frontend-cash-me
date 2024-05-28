import 'package:flutter/foundation.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final class WebsocketService {
  static final WebsocketService instance = WebsocketService();

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return ApiConstants.baseURL;
      default:
        // Production host URL
        return "";
    }
  }

  //Socket instance
  IO.Socket get socket => IO.io(
      _fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());

  initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint('Websocket connected');
      });
    } catch (e) {
      debugPrint('Error connecting to websocket: $e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint('Websocket disconnected'));
  }

  //Getting data from subscribed messages and calling onEvent callback
  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  //Sending data to any channel
  void webSocketSender(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }
}
