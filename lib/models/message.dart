import 'package:office_flutter_translate_app/pages/translate_page/chat/widgets/flat_chat_message.dart';

class Message {
  final String message;
  final MessageType messageType;
  final String time;
  final bool showTime;

  Message({this.message, this.messageType, this.time, this.showTime});
}