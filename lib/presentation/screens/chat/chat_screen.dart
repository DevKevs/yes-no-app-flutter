import 'package:flutter/material.dart';
import 'package:flutter_yes_no_app/domain/entities/message.dart';
import 'package:flutter_yes_no_app/presentation/providers/chat_provider.dart';
import 'package:flutter_yes_no_app/presentation/widgets/chat/another_message_bubble.dart';
import 'package:flutter_yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:flutter_yes_no_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.scdn.co/image/ab6761610000e5ebb13f156fb3bdd319dc714d6f'),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.phone),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam_rounded),
            ),
          ],
          title: const Text('El Temach 💪'),
          centerTitle: false,
        ),
        body: const _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.scrollController,
                itemCount: chatProvider.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = chatProvider.messages[index];
                  return (message.fromWho == FromWho.another)
                      ? AnotherMessageBubble(message: message)
                      : MyMessageBubble(message: message);
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MessageFieldBox(onValue: chatProvider.sendMessage),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
