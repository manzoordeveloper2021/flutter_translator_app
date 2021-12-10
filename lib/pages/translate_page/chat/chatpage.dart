import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

import '../text_translate_page/choose_language.dart';
import 'widgets/first_person_chat.dart';
import 'widgets/flat_chat_message.dart';

import 'widgets/second_person_chat.dart';



class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).initVoice();
    Provider.of<ChatProvider>(context, listen: false).initTts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return Expanded(
                child: chatProvider.messages.length == 0
                    ? Center(
                        child: Text(
                        'Tap below mic to start chat',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          return FlatChatMessage(
                            message: chatProvider.messages[index].message,
                            messageType:
                                chatProvider.messages[index].messageType,
                            showTime: chatProvider.messages[index].showTime,
                            time: chatProvider.messages[index].time,
                          );
                        }),
              );
            },
          ),
          Container(
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FirstPersonChat(),
                      SecondPersonChat(),
                    ],
                  ),
                ),
                ChooseLanguage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
