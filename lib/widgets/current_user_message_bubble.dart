
import 'package:chatpage/message_model.dart';
import 'package:flutter/material.dart';

class CurrentUserMessageBubble extends StatelessWidget {
  const CurrentUserMessageBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF006B),
                      Color(0xFFFF4593),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius:
                const BorderRadius.all(Radius.circular(18))
                    .copyWith(
                    topRight: const Radius.circular(4))),
            child: Text(message.message,
            style: const TextStyle(
              color: Colors.white
            ),
            ),
          ),
        )
      ],
    );
  }
}