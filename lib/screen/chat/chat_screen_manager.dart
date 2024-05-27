import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/message.dart';
import 'package:pocket_swap_fisi/domain/usecases/websocket_usecase.dart';

mixin class ChatScreenManager {
  List<Message> messages = [];
  final TextEditingController msgController = TextEditingController();

  listenMessageEvent(VoidCallback setState) {
    WebsocketUseCase.instance.webSocketReceiver("chat_update", (data) {
      messages.add(Message.fromJson(data));
      setState();
    });
  }

  sendMessage(String sender, VoidCallback setState) {
    final Message data = Message(sender: sender, message: msgController.text);

    WebsocketUseCase.instance.webSocketSender("chat_update", data.toJson());
    //Reset input
    msgController.text = "";
    setState();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }

}
