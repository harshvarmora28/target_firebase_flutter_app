import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  const MessageTile({super.key, required this.message, required this.sender, required this.sentByMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14, bottom: 2, left: widget.sentByMe ? 0 : 14, right: widget.sentByMe ? 14 : 0,),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe ? const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30) ,
        padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: widget.sentByMe ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ) : const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          // color: widget.sentByMe ? Theme.of(context).primaryColor : Color.fromARGB(255, 88, 255, 138),
          color: widget.sentByMe ? Color.fromARGB(255, 255, 133, 180) : Color.fromARGB(255, 88, 255, 138),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -0.5),
            ),
            const SizedBox(height: 8,),
            Text(widget.message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black),)
          ],
        ),
      ),
    );
  }
}
