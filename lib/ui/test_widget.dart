// import 'package:devfest_agenda/models/chat_message_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ChatList extends StatelessWidget {
//   final List<ChatMessageModel> chat;
//
//   const ChatList({
//     required this.chat,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final textTheme = theme.textTheme;
//
//     return ListView.builder(
//       reverse: true,
//       itemCount: chat.length,
//       itemBuilder: (context, index) {
//         final message = chat[index];
//         return Container(
//           padding: EdgeInsetsDirectional.only(
//             start: message.fromAssistant ? 8.0 : 24,
//             end: message.fromAssistant ? 24.0 : 8,
//             top: 8.0,
//             bottom: 8.0,
//           ),
//           alignment: message.fromAssistant
//               ? AlignmentDirectional.centerStart
//               : AlignmentDirectional.centerEnd,
//           child: Card(
//             color: getCardColor(message, colorScheme),
//             shape: getCardShape(message),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (message.fromAssistant) ...[
//                     Text(
//                       "Devfest assistant",
//                       style: textTheme.titleSmall,
//                     ),
//                     const SizedBox(height: 4.0),
//                   ],
//                   if (message.loading)
//                     const ShimmerLoading()
//                   else
//                     MarkdownBody(data: message.message),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Color getCardColor(ChatMessageModel message, ColorScheme colorScheme) {
//     if (message.loading) {
//       return colorScheme.surface;
//     } else {
//       return message.fromAssistant
//           ? colorScheme.tertiaryContainer
//           : colorScheme.secondaryContainer;
//     }
//   }
//
//   RoundedRectangleBorder getCardShape(ChatMessageModel message) {
//     return RoundedRectangleBorder(
//         side: BorderSide(
//             color: message.loading ? Colors.grey : Colors.transparent),
//         borderRadius: BorderRadiusDirectional.only(
//           topStart: const Radius.circular(8.0),
//           topEnd: const Radius.circular(8.0),
//           bottomStart: Radius.circular(message.fromAssistant ? 0.0 : 8.0),
//           bottomEnd: Radius.circular(message.fromAssistant ? 8.0 : 0.0),
//         ));
//   }
// }
//
// class ShimmerLoading extends StatelessWidget {
//   const ShimmerLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Shimmer.fromColors(
//       baseColor: colorScheme.surfaceContainerHighest,
//       highlightColor: colorScheme.surfaceContainer,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 color: colorScheme.surface),
//             child: const Text("Message loading long text"),
//           ),
//           const SizedBox(
//             height: 4.0,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4),
//                 color: colorScheme.surface),
//             child: const Text("Message loading"),
//           ),
//         ],
//       ),
//     );
//   }
// }
