import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.belongsToMe,
    {
      this.key,
    }
  ): super(key: key);

  final Key key;
  final String userName;
  final String userImage;
  final String message;
  final bool belongsToMe;

  @override
  Widget build(BuildContext context) {
    Color _defaultTextColor = belongsToMe ? Colors.black : 
      Theme.of(context).accentTextTheme.headline1.color;

    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToMe ? MainAxisAlignment.end :
            MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToMe ? Colors.grey[300] : 
                  Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: belongsToMe ? Radius.circular(12) : 
                    Radius.circular(0),
                  bottomRight: belongsToMe ? Radius.circular(0) : 
                    Radius.circular(12)
                  ),
              ),
              width: 140,
              margin: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: belongsToMe ? 
                  CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _defaultTextColor,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: _defaultTextColor,
                    ),
                    textAlign: belongsToMe ? 
                      TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToMe ? null : 128.0,
          right: belongsToMe ? 128.0 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              this.userImage,
            ),
          ),
        ),
      ],
    );
  }
}