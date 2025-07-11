import 'package:devfest_agenda/helpers/api_helper.dart';
import 'package:devfest_agenda/helpers/gemini_helper.dart';
import 'package:devfest_agenda/main.dart';
import 'package:devfest_agenda/models/chat_message_model.dart';
import 'package:devfest_agenda/models/devfest_model.dart';
import 'package:devfest_agenda/ui/chat_list.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
class AssistantSheet extends StatefulWidget {
  const AssistantSheet({super.key});

  @override
  _AssistantSheetState createState() => _AssistantSheetState();
}

class _AssistantSheetState extends State<AssistantSheet> {
  final textController = TextEditingController();

  String? loadingMessage;

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surface,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ChatList(chat: localChat),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: colorScheme.primaryContainer,
            child: TextField(
              enabled: loadingMessage == null,
              textInputAction: TextInputAction.send,
              controller: textController,
              onSubmitted: _sendMessage,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: colorScheme.onPrimaryContainer,
                ),
                onPressed: loadingMessage == null
                    ? () {
                        _sendMessage(textController.text);
                      }
                    : null,
              )),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    loadingMessage = text;
    setState(() {});
    var response =
        await chat.sendMessage(Content.text(text));
    final functionCalls = response.functionCalls;

    if (functionCalls.isNotEmpty) {
      response = await _handleFunctionCalls(functionCalls);
    }

    loadingMessage = null;
    textController.clear();
    setState(() {});
  }

  Future<GenerateContentResponse> _handleFunctionCalls(Iterable<FunctionCall> functionCalls) async {
    final functionCall = functionCalls.first;
    final result = switch (functionCall.name) {
    // Forward arguments to the hypothetical API.
      listDevfestMethodCall => await listDevfests(),
      findDevfestByDateMethodCall =>
      await findDevfestsByDate(functionCall.args),
      _ => throw UnimplementedError(
          'Function not implemented: ${functionCall.name}')
    };

    switch (functionCall.name) {
    // Forward arguments to the hypothetical API.
      case listDevfestMethodCall:
        appNotifier.deselect();
      case findDevfestByDateMethodCall:
        appNotifier.select(result);
    }

    return chat.sendMessage(
      Content.functionResponse(
        functionCall.name,
        devfestModelsToMap(result),
      ),
    );
  }

  List<ChatMessageModel> get localChat {
    final history = chat.history.toList().reversed;
    return [
      if (loadingMessage != null) ...[
        ChatMessageModel(
          message: "loading",
          fromAssistant: true,
          loading: true,
        ),
        ChatMessageModel(
          message: loadingMessage!,
          fromAssistant: false,
          loading: false,
        ),
      ],
      for (final message in history)
        if (message.parts.any((e) => e is TextPart))
          ChatMessageModel.fromContent(message),
      ChatMessageModel(
        message: "Welcome to Devfest assistant! how may I help you?",
        fromAssistant: true,
        loading: false,
      ),
    ];
  }
}

