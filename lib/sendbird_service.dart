import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendbirdService {
  final SendbirdSdk _sendbirdSdk;

  SendbirdService(this._sendbirdSdk);

  Future<List<GroupChannel>> getGroupChannels() async {
    await _connect();
    final query = GroupChannelListQuery()
      ..memberStateFilter = MemberStateFilter.joined
      ..order = GroupChannelListOrder.latestLastMessage
      ..limit = 15;
    return query.loadNext();
  }

  Future<GroupChannel> getGroupChannel(String channelUrl) async {
    await _connect();
    return GroupChannel.getChannel(channelUrl);
  }

  Future<void> _connect() async {
    final testUserId = dotenv.env['TEST_USER_ID'];
    if (testUserId != null) {
      await _sendbirdSdk.connect(testUserId);
      print(
          '>>> connect awaited | state: ${_sendbirdSdk.getConnectionState()}');
      return;
    }
    throw 'TEST_USER_ID is required. Please add to your .env';
  }
}
