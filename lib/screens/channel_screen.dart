import 'package:flutter/material.dart';
import 'package:sendbird_flutter_issues/sendbird_service.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelScreen extends StatelessWidget {
  static const routeName = '/channel';

  final String _channelUrl;
  final SendbirdService _sendbird;

  const ChannelScreen(this._sendbird, this._channelUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GroupChannel>(
        future: _sendbird.getGroupChannel(_channelUrl),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            final groupChannel = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(groupChannel.name ?? 'Unknown'),
              ),
              body: Column(
                children: [
                  Text(groupChannel.name ?? 'Unknown'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
