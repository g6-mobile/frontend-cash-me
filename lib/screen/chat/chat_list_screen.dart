import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:pocket_swap_fisi/screen/chat/chat_card.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart'; //S

@RoutePage()
class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SubtitleText(
            text: S.current.ChatListTitle, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Consumer<RoomProvider>(
        builder: (context, roomProvider, child) {
          roomProvider.getRooms();
          final rooms = roomProvider.rooms;
          
          return ListView.builder(
            itemCount: rooms.length +
                1, // +1 para incluir el Divider como primer elemento
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                );
              }
              return ChatCard(room: rooms[index - 1]);
            },
          );
        },
      ),
    );
  }
}
