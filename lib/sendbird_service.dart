import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendbirdService {
  final SendbirdSdk _sendbirdSdk;

  SendbirdService(this._sendbirdSdk) {
    _sendbirdSdk.addConnectionEventHandler(
        'CONNECTION_EVENT_HANDLER', MyConnectionEventListener());
  }

  Future<List<GroupChannel>> getGroupChannels() async {
    print('>>> getGroupChannels()');
    await _connect();
    final query = GroupChannelListQuery()
      ..memberStateFilter = MemberStateFilter.joined
      ..order = GroupChannelListOrder.latestLastMessage
      ..limit = 15;
    return query.loadNext();
  }

  Future<GroupChannel> getGroupChannel(String channelUrl) async {
    print('>>> getGroupChannel($channelUrl)');
    await _connect();
    return GroupChannel.getChannel(channelUrl);
  }

  Future<void> _connect() async {
    final testUserId = dotenv.env['TEST_USER_ID'];
    if (testUserId != null) {
      await _sendbirdSdk.connect(testUserId).catchError((err) {
        print('>>> Sendbird connect() error!');
        throw err;
      });
      print(
          '>>> connect awaited | state: ${_sendbirdSdk.getConnectionState()}');
      return;
    }
    throw 'TEST_USER_ID is required. Please add to your .env';
  }
}

class MyConnectionEventListener extends ConnectionEventHandler {
  @override
  void onReconnectionStarted() {
    print('>>> onReconnectionStarted');
    super.onReconnectionStarted();
  }

  @override
  void onReconnectionCanceled() {
    print('>>> onReconnectionCanceled');
    super.onReconnectionCanceled();
  }

  @override
  void onReconnectionFailed() {
    print('>>> onReconnectionFailed');
    super.onReconnectionFailed();
  }

  @override
  void onReconnectionSucceeded() {
    print('>>> onReconnectionSucceeded');
    super.onReconnectionSucceeded();
  }
}
