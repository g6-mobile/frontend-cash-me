import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatefulWidget {
  final Room room;

  const ChatCard({Key? key, required this.room}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);
    authProvider.loadUser();
    final loggedUser = authProvider.user;

    roomProvider.getChats(widget.room.id, GetChat());
    final chats = roomProvider.chats;

    final otherUser = widget.room.members
        .firstWhere((element) => element.id != loggedUser?.id);
    
    final lastMessage = chats.messages.isNotEmpty ? chats.messages[0] : null;

    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(ChatRoute(room: widget.room));
      },
      child: Column(
        children: [
          loggedUser != null && lastMessage != null
              ? ListTile(
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: ClipOval(
                      child: Image.network(otherUser.userPhoto ?? '',
                          fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(
                    '${otherUser.firstName} ${otherUser.lastName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.done_all),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        lastMessage.content,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  trailing:
                      Text(formatCreatedAt(lastMessage.createdAt.toString())),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: ClipOval(
                        child: Container(color: Colors.white),
                      ),
                    ),
                    title:
                        Container(width: 80, height: 10, color: Colors.white),
                    subtitle:
                        Container(width: 50, height: 10, color: Colors.white),
                  ),
                ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

String formatCreatedAt(String createdAt) {
  final DateTime parsedDate = DateTime.parse(createdAt).toLocal();
  final DateTime now = DateTime.now();
  final DateFormat formatter;

  if (parsedDate.year == now.year &&
      parsedDate.month == now.month &&
      parsedDate.day == now.day) {
    formatter = DateFormat('HH:mm');
  } else {
    formatter = DateFormat('EEEE');
  }

  return formatter.format(parsedDate);
}
