import 'package:firebase_vertexai/firebase_vertexai.dart';

class ChatMessageModel {
  ChatMessageModel({
    required this.message,
    required this.fromAssistant,
    required this.loading,
  });

  final String message;
  final bool fromAssistant;
  final bool loading;

  static fromContent(Content message) {
    return ChatMessageModel(
      message: [
        for (final part in message.parts)
          if (part is TextPart) part.text
      ].join(""),
      fromAssistant: message.role != "user",
      loading: false,
    );
  }
}
