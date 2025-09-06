import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final List<Message> messages;
  late final TextEditingController _controller;

  bool isShared = false;

  void toggleShared(bool val) => setState(() {
        isShared = val;
      });

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    messages = [
      Message(text: 'Hi'),
      Message(text: 'Hello', myText: true),
      Message(text: 'How are you'),
      Message(text: 'Good', myText: true),
      Message(text: 'Nice'),
      Message(text: 'Hello! Have you seen my backpack anywhere in Class?'),
    ];
  }

  void h(String value) {
    if (value.trim().endsWith('@share')) {
      toggleShared(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      releaseFocus: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reverseIndex = messages.length - 1 - index;
                var message = messages[reverseIndex];
                if (message.myText) {
                  return MyMessageBubble(message: message);
                }
                return MessageBubble(message: message);
              },
            ),
          ),
          Divider(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.attach_file_outlined),
              ),
              Expanded(
                child: Column(
                  children: [
                    isShared
                        ? SmartSuggestionShare(
                            onCancel: () => toggleShared(false),
                          )
                        : SizedBox.shrink(),
                    TextField(
                      controller: _controller,
                      onChanged: h,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFFAFAFA),
                        hintText: 'Type your message here..',
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: isShared
                              ? BorderRadius.vertical(
                                  bottom: Radius.circular(14.82),
                                )
                              : BorderRadius.circular(14.82),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Send',
                  style: TextStyle(color: Color.fromRGBO(232, 121, 2, 1)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SmartSuggestionShare extends StatelessWidget {
  const SmartSuggestionShare({
    super.key,
    this.onCancel,
  });

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(14.82),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Text('Share'),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                SmartSuggestionOption(label: 'Post'),
                SmartSuggestionOption(
                  label: 'Note',
                  isPost: false,
                ),
              ],
            ),
          ),
          IconButton(onPressed: onCancel, icon: Icon(Icons.cancel)),
        ],
      ),
    );
  }
}

class SmartSuggestionOption extends StatelessWidget {
  const SmartSuggestionOption({
    super.key,
    required this.label,
    this.isPost = true,
  });

  final String label;
  final bool isPost;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(
                  isPost ? Icons.feed_outlined : Icons.book_outlined,
                  size: 22,
                ),
                Text(label),
              ],
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

class MyMessageBubble extends StatelessWidget {
  const MyMessageBubble({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 250),
        padding: EdgeInsets.all(20).copyWith(bottom: 7.32),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 247, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(19.51),
            topLeft: Radius.circular(19.51),
            bottomLeft: Radius.circular(19.51),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              message.text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Icon(
                  Icons.check,
                  color: AppColors.green,
                  size: 16,
                ),
                Text(
                  '15:42',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        CircleAvatar(radius: 18),
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 250),
            padding: EdgeInsets.all(20).copyWith(bottom: 7.32),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 247, 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(19.51),
                bottomLeft: Radius.circular(19.51),
                bottomRight: Radius.circular(19.51),
              ),
            ),
            child: Text(
              message.text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}

class Message {
  final String text;
  final bool myText;

  const Message({
    required this.text,
    this.myText = false,
  });
}
