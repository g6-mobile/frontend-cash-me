import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/messages.dart';
import 'package:pocket_swap_fisi/domain/usecases/websocket_usecase.dart';

class MessageProvider extends ChangeNotifier {
  final List<Messages> _messages = [];
  List<Messages> get messages => _messages;
  final TextEditingController msgController = TextEditingController();

  Future<void> initializeSocketConnection() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');
    // Connect to websocket
    WebsocketUseCase.instance.initializeSocketConnection(token);

    // Listen chat channel
    WebsocketUseCase.instance.webSocketReceiver("new-chat", (data) {
      final transformedData = {      
        "sender_id": data['sender_id'],
        "content": data['content']        
      };      
      final message = Messages.fromJson(transformedData);
      _messages.add(message);      
      notifyListeners();
    });
  }

  void sendMessage(CreateChat createChat) {
    WebsocketUseCase.instance.webSocketSender("create", createChat.toJson());
    notifyListeners();
  }

  void disconnectFromSocket() {
    WebsocketUseCase.instance.disconnectFromSocket();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    return senderName == userName ? Alignment.topRight : Alignment.topLeft;
  }
}
