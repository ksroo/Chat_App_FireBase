import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String userName;
  final bool isMe;

  MessageBubble(this.message, this.userName, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
            !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
           borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(14),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(14),
            ),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6.color,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline6.color,
                ),
                textAlign:  !isMe ? TextAlign.end : TextAlign.start,
              )
            ],
          ),
        ),
      ],
    );
  }
}
