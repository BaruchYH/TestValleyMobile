import 'package:chatpage/media_res.dart';
import 'package:flutter/material.dart';

class BottomChatBar extends StatelessWidget {
  const BottomChatBar({
    super.key,
    required this.size,
    required this.controller,
    required this.onTab
  });

  final Size size;
  final TextEditingController controller;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.105,
      decoration: const BoxDecoration(color: Color(0xFF131313)),
      padding:
      const EdgeInsets.only(left: 4, right: 16, bottom: 8, top: 8),
      child: LayoutBuilder(builder: (context, constraintsSizes) {
        return Column(
          children: [
            SizedBox(
              height: constraintsSizes.maxHeight * 0.72,
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.83,
                            child: Image.asset(
                              MediaRes.addButton,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller
                        ,decoration: InputDecoration(
                            hintText: '메세지 보내기',
                            hintStyle: const TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 14,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400),
                            fillColor: const Color(0xFF1A1A1A),
                            filled: true,
                            contentPadding:
                            const EdgeInsets.only(left: 16, top: 4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: const BorderSide(
                                    color: Color(0xFF323232), width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: const BorderSide(
                                    color: Color(0xFF323232), width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: const BorderSide(
                                    color: Color(0xFF323232), width: 1)),
                            suffixIconConstraints: BoxConstraints(
                                maxHeight:
                                (constraintsSizes.maxHeight * 0.72) *
                                    0.5,
                                maxWidth:
                                ((constraintsSizes.maxHeight * 0.72) *
                                    0.5) +
                                    12),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                onTap: onTab,
                                child: Image.asset(
                                  MediaRes.sendButton,
                                ),
                              ),
                            )),
                        style: const TextStyle(
                            color: Color(0xFFFCFCFC),
                            decoration: TextDecoration.none),
                      ),
                    )
                  ],
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
