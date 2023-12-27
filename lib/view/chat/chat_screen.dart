import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/routes/routes_name.dart';
import '../../view/widgets/appbar.dart';
import '../../view/widgets/ui_search_input.dart';

import '../../res/style/app_colors.dart';
import '../../utils/dimens/dimens_manager.dart';
import '../widgets/ui_item_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    this.hasBackButton = false,
    super.key,
  });
  final bool hasBackButton;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late User? user;
  late Stream<QuerySnapshot> chatsStream;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    chatsStream = FirebaseFirestore.instance
        .collection('messages')
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, 'Đoạn chat', leading: widget.hasBackButton),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: DimensManager.dimens.setWidth(390),
            height: DimensManager.dimens.setHeight(48),
            child: const UISearchInput(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: chatsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                );
              }

              final chats = snapshot.data!.docs;

              if (chats.isEmpty) {
                return const Center(
                  child: Text('Không có tin nhắn nào.'),
                );
              }

              final latestChat = chats.first;
              final textChat = latestChat['text'];
              final createAt = latestChat['createAt'] as Timestamp;
              final timeChat = DateFormat('HH:mm').format(createAt.toDate());
              final messageSender = latestChat['email'];
              final currentUser = FirebaseAuth.instance.currentUser?.email;

              return UiItemChat(
                activeAvatar: true,
                textName: 'Nhóm thảo luận',
                fontWeightName: FontWeight.w700,
                textChat: textChat,
                colorTextChat: AppColors.hintSendChat,
                fontWeightChat: FontWeight.w600,
                timeChat: timeChat,
                isMe: messageSender == currentUser,
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.chatDetail, arguments: user);
                },
                avatar: '',
              );
            },
          ),
        ],
      ),
    );
  }
}
