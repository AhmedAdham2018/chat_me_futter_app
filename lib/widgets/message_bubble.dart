import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageTitle;
  final String messageSender;
  final bool isMe;
  MessageBubble({this.messageSender, this.messageTitle, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            messageSender,
            style: TextStyle(
              color: Colors.black45,
            ),
            textAlign: TextAlign.start,
          ),
          Material(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                '$messageTitle',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54, fontSize: 15),
              ),
            ),
            color: isMe ? Colors.blueAccent : Colors.white,
            elevation: 6,
          ),
        ],
      ),
    );
  }
}
