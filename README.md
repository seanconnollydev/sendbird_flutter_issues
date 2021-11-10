# sendbird_flutter_issues
A place for me to demonstrate issues with Sendbird's Flutter SDK

This video walks through how to reproduce `LoginTimeoutErrors`

[Video walkthrough](https://drive.google.com/file/d/1HIqPIBQNScqPELW48zIxrdGU5mFXukJI/view?usp=sharing)

1. Create a `.env` file and enter an APP_ID and a TEST_USER_ID in the `.env` file
2. Run the app in debug mode
3. Set a breakpoint somewhere in the `ChannelListScreen` build method
4. Background the app
5. Re-open the app and **quickly** click/tap the refresh button in the top right of the app bar
6. Pause on the breakpoint for at least 10 seconds
7. Attempt to open a channel and/or refresh again
8. You should see reqquests hanging and not resolving and eventually a `LoginTimeoutError` in the console

## November 20, 2021 Update
Tried updating `pubspec.yaml` to point to a branch that has a proposed fix for this issue.
```
sendbird_sdk:
    git:
      url: https://github.com/sendbird/sendbird-sdk-flutter
      ref: connection
```

This video walks through my experience with the `connection` branch where I still see `LoginTimeoutErrors`.

[Video walkthrough](https://drive.google.com/file/d/1GhQwHPl75KIjkqzyX-G5c-NzVh6s0QRC/view?usp=sharing)
