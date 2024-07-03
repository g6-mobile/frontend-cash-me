import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/message_provider.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Room room;

  const ChatScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final chatProvider = Provider.of<MessageProvider>(context, listen: false);
    chatProvider.initializeSocketConnection();
    super.initState();
  }

  @override
  void dispose() {
    final chatProvider = Provider.of<MessageProvider>(context, listen: false);
    chatProvider.disconnectFromSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer3<AuthProvider, MessageProvider, RoomProvider>(
        builder: (context, authProvider, messageProvider, roomProvider, child) {
          final user = authProvider.user;
          roomProvider.getChats(widget.room.id, GetChat());
          return Column(
            children: user != null
                ? <Widget>[
                    Expanded(
                        child:
                            buildMessages(messageProvider, roomProvider, user)),
                    buildInput(messageProvider, user.firstName),
                  ]
                : <Widget>[
                    const Center(child: Text("User not found")),
                  ],
          );
        },
      ),
    );
  }

  Widget buildMessages(
      MessageProvider messageProvider, RoomProvider roomProvider, User user) {    
    final combinedMessages = roomProvider.chats.messages;
    final chatUsers = roomProvider.chats.users;

    final ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
      child: ListView.builder(
          reverse: true,
          controller: scrollController,
          itemCount: combinedMessages.length,
          itemBuilder: (context, index) {
            final message = combinedMessages[index];
            return Align(
              alignment:
                  messageProvider.setMessageAlignment(message.senderId, user.id),
              child: Column(
                children: <Widget>[
                  Text(
                    chatUsers
                        .firstWhere((element) => element.id == message.senderId)
                        .firstName,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(message.content),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget buildInput(MessageProvider messageProvider, String name) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: messageProvider.msgController,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                final createChat = CreateChat(
                  roomId: widget.room.id,
                  content: messageProvider.msgController.text,
                );
                messageProvider.sendMessage(createChat);
                messageProvider.msgController.clear();
              },
              child: const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
