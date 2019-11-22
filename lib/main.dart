
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'note.dart';

void main() => runApp(new MaterialApp(home: new MyHomePage()));





class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Note> _notes = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://test.pero.io/words?level=0&words_count=3&phrases_count=3&offset=3';
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }


    return notes;


  }


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });


    //this.loadJsonData();
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(
        initSettings, onSelectNotification: selectNotification );

  }

  Future selectNotification(String payload){
    debugPrint('print payload : $payload');
    showDialog(context: context,builder: (_)=> AlertDialog(
      title: new Text('Notification') ,
      content: new Text('$payload'),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Пуш итерация'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _notes[index].source,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      _notes[index].translation,
                      style: TextStyle(
                          color: Colors.grey.shade600
                      ),
                    ),
                    new Text(
                      'Действует через 2 сек:',
                    ),
                    new RaisedButton(child:Text('Нажми') , onPressed: showNotification),
                  ],
                ),
              ),
            );
          },
          itemCount: _notes.length,
        )
    );
  }



  showNotification() async{

     var scheduledNotificationDateTime =
     new DateTime.now().add(new Duration(seconds: 4));
     var androidPlatformChannelSpecifics =
     new AndroidNotificationDetails('your other channel id',
         'your other channel name', 'your other channel description');
     var iOSPlatformChannelSpecifics =
     new IOSNotificationDetails();
     NotificationDetails platformChannelSpecifics = new NotificationDetails(
         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
       //const oneSec = const Duration(seconds:3);

       var n = 0;
      //  new Timer.periodic(oneSec, (Timer t) => n++);



        n++;
       await flutterLocalNotificationsPlugin.schedule(
            0,
            _notes[n++].source,
            _notes[n].translation,
            scheduledNotificationDateTime,
            platformChannelSpecifics);
     //}

     debugPrint('$n');
  }


}
