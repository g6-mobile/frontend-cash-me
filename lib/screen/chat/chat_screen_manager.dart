import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/message.dart';

mixin class ChatScreenManager {
  List<Message> messages = [];
  final TextEditingController msgController = TextEditingController();

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }

}
