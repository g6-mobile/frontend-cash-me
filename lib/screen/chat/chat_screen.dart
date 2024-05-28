import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/domain/usecases/websocket_usecase.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:pocket_swap_fisi/screen/chat/chat_screen_manager.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {  
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ChatScreenManager {
  @override
  void initState() {
    WebsocketUseCase.instance.initializeSocketConnection();

    listenMessageEvent(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder(
      future: userProvider.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final user = snapshot.data;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: <Widget>[
                Expanded(child: buildMessages(user!.firstName)),
                buildInput(user.firstName),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildMessages(String name) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: setMessageAlignment(messages[index].sender, name),
            child: Column(
              children: <Widget>[
                Text(messages[index].sender),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(messages[index].message),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget buildInput(String name) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: msgController,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () => sendMessage(name, () {
                setState(() {});
              }),
              child: const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
