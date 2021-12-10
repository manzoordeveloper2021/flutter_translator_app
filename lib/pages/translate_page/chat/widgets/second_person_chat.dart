import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class SecondPersonChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, voiceProvider, child) {
          return AvatarGlow(
            animate: voiceProvider.isListening2,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 50.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration:
            const Duration(milliseconds: 100),
            repeat: true,
            child: IconButton(
              iconSize: 50,
              icon: Image.asset(Strings.voiceButtonIcon),
              onPressed: voiceProvider.chat2,
            )
          );
        });
  }
}
