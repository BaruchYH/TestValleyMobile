import 'package:chatpage/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OtherUserMessageBubble extends StatelessWidget {
  const OtherUserMessageBubble({
    super.key,
    required this.showAvatar,
    required this.message,
    required this.size,
  });

  final bool showAvatar;
  final MessageModel message;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (showAvatar) ...[
            SizedBox(
              width: 32,
              height: 32,
              child: CircleAvatar(
                radius: 100,
                child: Image.asset(
                  message.message,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
          SizedBox(
            width: size.width * 0.80,
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(18))
                            .copyWith(
                          topLeft: const Radius.circular(4),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              message.nickname,
                              style: const TextStyle(
                                  color: Color(0xFFADADAD)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: (message.isActive ==
                                        false)
                                        ? const LinearGradient(
                                        colors: [
                                          Color(0xFF101010),
                                          Color(0xFF2F2F2F),
                                        ],
                                        begin:
                                        Alignment.topLeft,
                                        end: Alignment
                                            .bottomRight)
                                        : null,
                                    color: (message.isActive == true)
                                        ? const Color(0xFF46F9F5)
                                        : null))
                          ],
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*0.55
                          )
                          ,child: Text(message.message,
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.03,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.17,
                    child: Text(
                      DateFormat('h:mm').format(message.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF9C9CA3),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}