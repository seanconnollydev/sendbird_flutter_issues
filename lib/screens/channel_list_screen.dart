import 'package:flutter/material.dart';
import 'package:sendbird_flutter_issues/screens/channel_screen.dart';
import 'package:sendbird_flutter_issues/sendbird_service.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelListScreen extends StatefulWidget {
  static const routeName = '/channel-list';

  final SendbirdService _sendbird;

  const ChannelListScreen(this._sendbird, {Key? key}) : super(key: key);

  @override
  State<ChannelListScreen> createState() => _ChannelListScreenState();
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupChannel>>(
      future: widget._sendbird.getGroupChannels(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Sendbird'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh))
            ],
          ),
          body: ListView.separated(
            itemBuilder: (context, i) {
              final groupChannel = snapshot.data![i];
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ChannelScreen.routeName,
                    arguments: groupChannel.channelUrl,
                  );
                },
                title: Text(groupChannel.name ?? 'Unknown'),
              );
            },
            separatorBuilder: (_, i) => Divider(),
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }
}
