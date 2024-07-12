import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/domain/entities/user.dart';
import 'package:pocket_swap_fisi/providers/message_provider.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final Room room;
  final User loggedUser;
  final User otherUser;

  const ChatScreen(
      {Key? key,
      required this.room,
      required this.loggedUser,
      required this.otherUser})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController listScrollController = ScrollController();
  MessageProvider? chatProvider;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    chatProvider = Provider.of<MessageProvider>(context, listen: false);
    chatProvider!.initializeSocketConnection();

    listScrollController.addListener(() {
      if (listScrollController.position.atEdge &&
          listScrollController.position.pixels != 0 &&
          !_isLoadingMore) {
        _loadMoreChats();
      }
    });
  }

  @override
  void dispose() {
    chatProvider?.disconnectFromSocket();
    listScrollController.dispose();
    super.dispose();
  }

  _loadMoreChats() {
    setState(() {
      _isLoadingMore = true;
    });

    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    roomProvider.getChats(widget.room.id,
        GetChat(limit: 10 + roomProvider.chats.messages.length));

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.otherUser.firstName)),
      ),
      body: Consumer2<MessageProvider, RoomProvider>(
        builder: (context, messageProvider, roomProvider, child) {
          return Column(
            children: <Widget>[
              Expanded(
                  child: buildMessages(
                      messageProvider, roomProvider, widget.loggedUser)),
              buildInput(messageProvider),
            ],
          );
        },
      ),
    );
  }

  Widget buildMessages(
      MessageProvider messageProvider, RoomProvider roomProvider, User user) {
    final combinedMessages = roomProvider.chats.messages;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
      child: ListView.builder(
          reverse: true,
          controller: listScrollController,
          itemCount: combinedMessages.length,
          itemBuilder: (context, index) {
            final message = combinedMessages[index];
            final formattedTime = formatCreatedAt(message.createdAt ?? "");
            return Align(
              alignment: messageProvider.setMessageAlignment(
                  message.senderId, user.id),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(message.content),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget buildInput(MessageProvider messageProvider) {
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
              child: const Text("Enviar"),
            ),
          )
        ],
      ),
    );
  }
}

String formatCreatedAt(String createdAt) {
  DateTime parsedDate = DateTime.parse(createdAt);
  parsedDate = parsedDate.toUtc();
  final DateTime peruTime = parsedDate.subtract(const Duration(hours: 5));
  final DateTime now =
      DateTime.now().toUtc().subtract(const Duration(hours: 5));
  String formattedString;

  if (peruTime.year == now.year &&
      peruTime.month == now.month &&
      peruTime.day == now.day) {
    formattedString = DateFormat('HH:mm').format(peruTime);
  } else if (peruTime.year == now.year &&
      peruTime.month == now.month &&
      peruTime.day == now.day - 1) {
    formattedString = '${DateFormat('HH:mm').format(peruTime)} Ayer';
  } else if (peruTime.year == now.year &&
      peruTime.month == now.month &&
      peruTime.day > now.day - 7) {
    formattedString = DateFormat('HH:mm, EEEE').format(peruTime);
  } else if (peruTime.year == now.year) {
    formattedString = DateFormat('HH:mm, d MMM').format(peruTime);
  } else {
    formattedString = DateFormat('HH:mm, d MMM yyyy').format(peruTime);
  }

  return formattedString;
}
