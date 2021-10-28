import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sendbird_flutter_issues/screens/channel_list_screen.dart';
import 'package:sendbird_flutter_issues/screens/channel_screen.dart';
import 'package:sendbird_flutter_issues/sendbird_service.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final sendbirdSdk = SendbirdSdk(appId: dotenv.env['SENDBIRD_APP_ID']);
  final sendbird = SendbirdService(sendbirdSdk);
  runApp(MyApp(sendbird));
}

class MyApp extends StatelessWidget {
  final SendbirdService _sendbird;

  MyApp(this._sendbird);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ChannelListScreen.routeName,
      routes: {
        ChannelListScreen.routeName: (_) => ChannelListScreen(_sendbird),
        ChannelScreen.routeName: (context) => ChannelScreen(
            _sendbird, ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
