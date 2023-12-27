import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../res/constant/app_assets.dart';
import '../../res/style/app_colors.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_input_chat.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final messageTextController = TextEditingController();
  late User loggedInUser;

  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Nhóm thảo luận'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(firestore: FirebaseFirestore.instance, loggedInUser: loggedInUser),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UiInputChat(
                      onChanged: (value) {
                        messageText = value;
                      },
                      controller: messageTextController,
                    ),
                    IconButton(
                        onPressed: () {
                          messageTextController.clear();
                          FirebaseFirestore.instance.collection('messages').add({
                            'text': messageText,
                            'email': loggedInUser.email,
                            'createAt': DateTime.now(),
                          });
                        },
                        icon: SvgPicture.asset(
                          AppAssets.icSend,
                          color: AppColors.primaryColor,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.firestore, required this.loggedInUser})
      : super(key: key);

  final FirebaseFirestore firestore;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').orderBy('createAt', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data!.docs;
        List<MessageBubble> messageBubbles = [];
        String? lastemail;

        for (var message in messages) {
          final messageText = message['text'];
          final messageemail = message['email'];
          final createAt = message['createAt'];

          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            email: messageemail,
            text: messageText,
            isMe: currentUser == messageemail,
            createAt: createAt,
          );

          if (messageemail != lastemail) {
            lastemail = messageemail;
            messageBubbles.add(messageBubble);
          } else {
            messageBubbles.add(messageBubble.copyWith(showemail: false));
          }
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles.reversed.toList(),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    Key? key,
    required this.email,
    required this.text,
    required this.isMe,
    required this.createAt,
    this.showemail = true,
  }) : super(key: key);

  final String email;
  final String text;
  final bool isMe;
  final Timestamp createAt;
  final bool showemail;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();

  MessageBubble copyWith({
    String? email,
    String? text,
    bool? isMe,
    Timestamp? createAt,
    bool? showemail,
  }) {
    return MessageBubble(
      email: email ?? this.email,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      createAt: createAt ?? this.createAt,
      showemail: showemail ?? this.showemail,
    );
  }
}

class _MessageBubbleState extends State<MessageBubble> with SingleTickerProviderStateMixin {
  bool showTimestamp = false;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..repeat(reverse: true);
    _colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.lightBlue).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = widget.createAt.toDate();
    final now = DateTime.now();
    final isToday =
        dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year;
    final formattedDate =
        isToday ? DateFormat('HH:mm').format(dateTime) : DateFormat('dd/MM/yyyy').format(dateTime);

    String emailText;
    if (widget.email.split('@')[0] == 'ctsv') {
      emailText = 'Phòng công tác sinh viên';
    } else if (widget.email.split('@')[0] == 'gvcn') {
      emailText = 'Giáo viên chủ nhiệm';
    } else {
      emailText = widget.email.split('@')[0];
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showTimestamp = !showTimestamp;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            if (widget.showemail && !widget.isMe)
              Text(
                emailText,
                style: TextStyle(
                  fontSize: 12.0,
                  color: widget.email.split('@')[0] == 'ctsv' || widget.email.contains('gvcn')
                      ? Colors.blue
                      : AppColors.black.withOpacity(0.7),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.05),
                    blurRadius: 2,
                  ),
                ],
                color: widget.isMe ? AppColors.requiredColor : AppColors.backgroundColor,
                borderRadius: widget.isMe
                    ? const BorderRadius.all(
                        Radius.circular(30.0),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                border: Border.all(
                  width: 2.0,
                  color: widget.isMe ? AppColors.blue : Colors.black.withOpacity(0.06),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius:
                    (widget.email.contains('ctsv') || widget.email.contains('gvcn')) && !widget.isMe
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          )
                        : const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                border: Border.all(
                  width: 2.0,
                  color: widget.email.contains('ctsv') || widget.email.contains('gvcn')
                      ? _colorAnimation.value ?? Colors.transparent
                      : Colors.transparent,
                ),
              ),
              // transform: Matrix4.rotationZ(_animationController.value * 2 * 3.14),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.isMe ? Colors.white : AppColors.headerTextColor,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    if (showTimestamp)
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
