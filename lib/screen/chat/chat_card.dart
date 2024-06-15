import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(const ChatRoute());
      },
      child: const Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
            ),
            title: Text(
              "Diego Zavala",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Deseo un chash de 100 soles",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            trailing: Text("11:11"),
          ),
          Padding(
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
