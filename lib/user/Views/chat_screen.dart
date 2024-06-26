import 'package:flutter/material.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, required this.isSentByUser});
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "رفيق صحتك الالكتروني",
      ),
      endDrawer: CustomEndDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                final color = message.isSentByUser
                    ? const Color(0xff28CC9E)
                    : const Color(0xffE6E6E6);
                final alignment = message.isSentByUser
                    ? WrapAlignment.end
                    : WrapAlignment.start;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Wrap(
                    alignment: alignment,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.isSentByUser) ...[
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    message.text,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (!message.isSentByUser) ...[
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, right: 12, left: 12),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          message.text,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -1,
                                    left: -9,
                                    child: Image.asset(
                                      'assets/Images/Group 104.png',
                                      width: 55,
                                      // Adjust the fit as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff196B69),
                        borderRadius: BorderRadius.circular(40)),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff28CC9E)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Color(0xff28CC9E),
                        ),
                      ),
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Color(0xff28CC9E)),
                      //     borderRadius: BorderRadius.circular(100)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      hintText: 'ادخل سوالك ....',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }

  void _sendMessage() async {
    String messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: messageText, isSentByUser: true));
        _messageController.clear();
      });

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      var response = await http.post(
        Uri.parse('https://gemini-chatbot-8c18.onrender.com/chat'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'msg': messageText}),
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        String reply = decodedResponse['response'];
        setState(() {
          _messages.add(Message(text: reply, isSentByUser: false));
        });
      } else {
        setState(() {
          _messages
              .add(Message(text: 'Failed to fetch reply', isSentByUser: false));
        });
      }
    }
  }
}
