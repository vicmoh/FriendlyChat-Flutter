//https://codelabs.developers.google.com/codelabs/flutter/#3
//https://codelabs.developers.google.com/codelabs/flutter/#8
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
 runApp(new FriendlyChatApp()); 
}//end main

class FriendlyChatApp extends StatelessWidget{
  //instanecc
  final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light
  );
  final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[100]
  );

  @override Widget build(BuildContext context){
    print("app build");
    var title = "Firendly Chat";
    var chatScreen = new ChatScreen();
    var page = new MaterialApp(
      title: title, 
      home: chatScreen,
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
    );
    return page;
  }//end overide
}//end class

class ChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // print("chat screen build");
    // var titleBar = new Text("Friendly Chat 2");
    // var bar = new AppBar(title: titleBar);
    // var scaff = new Scaffold(appBar: bar);
    return new ChatScreenState();
  }//end overide
}//end class

class ChatMessage extends StatelessWidget {
  //instance
  String text;

  // constructor
  ChatMessage({String text}){
    this.text = text;
  }//end constructor

  //create a message box
  Widget _messageBox(String name, String message, {Object context}){
    // circle avatar
    var avatarContainer = new Container(
      margin: EdgeInsets.only(right: 16.0),
      child: new CircleAvatar(child: new Text("Name"))
    );
    // message
    var messageContainer = new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(name, style: Theme.of(context).textTheme.subhead),
          new Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: new Text(message)
          )
        ],
      )
    );
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[avatarContainer, messageContainer],
    );
  }//end massage box

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: _messageBox("Vic", this.text, context: context)
    );
  }//end widget
}//end massage

class ChatScreenState extends State<ChatScreen>{
  // instance
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messageList = <ChatMessage>[];
  bool _isComposing = false;

  // method to clear the message going to be sent
  void _handleSubmitted(String text){
    print("Send button has been clicked");
    _textController.clear();
    ChatMessage message = new ChatMessage(text: text); 
    setState((){
      _messageList.insert(0, message);
      _isComposing = false;
    });
  }//end submit handler
  
  Widget _messageListView(){
    return Flexible(
      child: new ListView.builder(
        padding: new EdgeInsets.all(8.0),
        reverse: true,//make lists start at bottom
        itemBuilder: (_, int index){
          print("index of message list = $index");
          return _messageList[index];
        },//show the list each iter
        itemCount: _messageList.length,
      )
    );
  }//end message list

  // for composing a massage
  Widget _buildTextComposer(){
    //textfield for send
    var text = TextField(
      controller: _textController,
      onSubmitted: _handleSubmitted,
      decoration: new InputDecoration.collapsed(hintText: "Send a message..."),
      onChanged: (String text){
        setState((){_isComposing = text.length > 0;});
      },
    );
    var messageSendField = new Flexible(child: text);

    // the send icon button
    var sendContainer = new Container(
      margin: new EdgeInsets.symmetric(horizontal: 4.0),
      child: new IconButton(
        icon: new Icon (Icons.send),
        onPressed: (){ 
          return _handleSubmitted(_textController.text);
        }//end on pressed
      )//end child
    );//end container

    //container for the message field and send button
    var containerMargin = const EdgeInsets.symmetric(horizontal: 8.0);
    var container = new Container(
      margin: containerMargin, 
      child: new Row(
        children: <Widget>[messageSendField, sendContainer],
      )
    );
    
    // icon theme
    var theme = new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: container,
    );

    //create a divider
    var textSenderContainer = new Container(
      decoration: new BoxDecoration(color: Theme.of(context).cardColor),
      child: theme
    );
    return textSenderContainer;
  }//end func

  @override
  Widget build(BuildContext context) {
    var title = new Text("Fiendly Chat");
    var bar = new AppBar(title: title);
    return new Scaffold(
      appBar: bar, 
      body: new Column(
        children: <Widget>[
          _messageListView(), 
          new Divider(height: 1.0),
          _buildTextComposer()
        ],
      )
    );
  }//end func
}//end class