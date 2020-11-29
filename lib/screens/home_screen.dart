import 'package:chat_me/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  User loggedUser;

  final _fireStore = FirebaseFirestore.instance;
  String _messageTitle;

  void getCurrentUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        loggedUser = currentUser;
        print(currentUser);
      }
    } catch (error) {
      print('ERROR: $error');
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                //Implement logout functionality
                try {
                  await _auth.signOut();
                  Navigator.pop(context);
                } catch (error) {
                  print('ERROR: $error');
                }
              }),
        ],
        title: Text('Chat me'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _fireStore.collection('messages').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                          backgroundColor: Colors.amberAccent);
                    }
                    final messages = snapshot.data.docs.reversed;
                    final List<MessageBubble> bubbleMessages = [];
                    for (var message in messages) {
                      final String messageTitle =
                          message.data()['messageTitle'];
                      final String messageSender = message.data()['sender'];
                      final currentUser = loggedUser.email;
                      final sender = messageSender.split('@');
                      final messageBubble = MessageBubble(
                        messageTitle: messageTitle,
                        messageSender: sender[0],
                        isMe: currentUser == messageSender,
                      );
                      bubbleMessages.add(messageBubble);
                    }
                    return ListView(
                      padding: const EdgeInsets.all(10),
                      reverse: true,
                      children: bubbleMessages,
                    );
                  }),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (messageValue) {
                        //Do something with the user input.
                        _messageTitle = messageValue;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _controller.clear();
                      _fireStore.collection('messages').add({
                        'messageTitle': _messageTitle,
                        'sender': loggedUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
