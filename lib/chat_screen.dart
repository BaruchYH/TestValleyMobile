import 'dart:convert';
import 'package:chatpage/constants.dart';
import 'package:chatpage/media_res.dart';
import 'package:chatpage/message_model.dart';
import 'package:chatpage/widgets/bottom_chat_bar.dart';
import 'package:chatpage/widgets/current_user_message_bubble.dart';
import 'package:chatpage/widgets/other_user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0D0D),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0E0D0D),
        leading: GestureDetector(
          onTap: () {},
          child: Image.asset(
            MediaRes.backButton,
            width: 40,
            height: 40,
          ),
        ),
        title: const Text(
          '강남스팟',
          style: TextStyle(
              color: Color(0xFFFCFCFC),
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              MediaRes.listButton,
              width: 44,
              height: 40,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  MessageModel message = messages.reversed.toList()[index];
                  if (message.userId == '673105') {
                    return CurrentUserMessageBubble(message: message);
                  } else {
                  return OtherUserMessageBubble(showAvatar: false, message: message, size: size);
                }
                  },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: messages.length,
                reverse: true,
              )),
          BottomChatBar(size: size,controller: controller,onTab: (){
            FocusScope.of(context).unfocus();
            if(controller.text.isNotEmpty){
              sendBirdPostRequest(message: controller.text.trim());
              controller.clear();
            }
          },)
        ],
      ),
    );
  }

  Future<void> fetchMessages() async {
    final uri = Uri.parse('$fetchMessagesBaseUrl/messages?message_ts=1706692485');
    final headers = {
      'Api-Token': token,
      'Host': 'api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> messagesJson = jsonDecode(response.body)['messages'];

      List<MessageModel> messages = messagesJson.map((json) {
        return MessageModel(
          type: json['type'],
          messageId: json['message_id'],
          message: json['message'],
          createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
          userId: json['user']['user_id'],
          nickname: json['user']['nickname'],
          isActive: json['user']['is_active'],
        );
      }).toList();
      setState(() {
        this.messages = messages;
      });

    } else {
      throw Exception('Failed to load messages');
    }
  }

  void sendBirdPostRequest({required String message}) async {
    const String apiUrl =
        'https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com/v3/open_channels/sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211/messages';

    final Map<String, String> headers = {
      'Api-Token': 'f93b05ff359245af400aa805bafd2a091a173064',
      'Host': 'api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'message_type': 'MESG',
      'user_id': '673105',
      'message': message,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
        setState(() {
          final dynamic json = jsonDecode(response.body);
          messages = messages..add(MessageModel(
            type: json['type'],
            messageId: json['message_id'],
            message: json['message'],
            createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
            userId: json['user']['user_id'],
            nickname: json['user']['nickname'],
            isActive: json['user']['is_active'],
          ));
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}






