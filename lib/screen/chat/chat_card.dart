import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/get_chat.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatefulWidget {
  final Room room;

  const ChatCard({Key? key, required this.room}) : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  void initState() {
    super.initState();
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    roomProvider.getChats(widget.room.id, GetChat());
    authProvider.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, RoomProvider>(
        builder: (context, authProvider, roomProvider, child) {
      final loggedUser = authProvider.user;
      final chats = roomProvider.chats;
      final otherUser = widget.room.members
          .firstWhere((element) => element.id != loggedUser?.id);

      final lastMessage = chats.messages.isNotEmpty ? chats.messages[0] : null;
      return InkWell(
        onTap: () {
          AutoRouter.of(context).push(ChatRoute(
              room: widget.room,
              loggedUser: loggedUser!,
              otherUser: otherUser));
        },
        child: Column(
          children: [
            ListTile(
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
                  if (lastMessage?.senderId == loggedUser?.id)
                    const Icon(Icons.done_all),
                  const SizedBox(
                    width: 3,
                  ),
                  lastMessage != null
                      ? Text(
                          lastMessage.content,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        )
                      : const Text(''),
                ],
              ),
              trailing: lastMessage != null
                  ? Text(formatCreatedAt(lastMessage.createdAt.toString()))
                  : const Text(''),
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
    });
  }
}

String formatCreatedAt(String createdAt) {
  DateTime parsedDate = DateTime.parse(createdAt);
  parsedDate = parsedDate.toUtc();
  final DateTime peruTime = parsedDate.subtract(const Duration(hours: 5));

  final DateTime now =
      DateTime.now().toUtc().subtract(const Duration(hours: 5));
  DateFormat formatter;

  if (peruTime.year == now.year &&
      peruTime.month == now.month &&
      peruTime.day == now.day) {
    formatter = DateFormat('HH:mm');
  } else {
    formatter = DateFormat('EEEE');
  }

  return formatter.format(peruTime);
}
