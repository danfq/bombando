## Bombando: Privacy Policy

This is an open source Android app developed solely by myself, DanFQ.<br>
The source code is available on GitHub under the MIT license; the app is also available on Google Play.

As an avid **Android** user myself, I take privacy very seriously.

I hereby state that I have not programmed this app to collect any personally identifiable information.

### Permissions and Their Explanation

The following are the **Permissions** used by the App:

```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_SETTINGS" tools:ignore="ProtectedPermissions" />
```

Below, is a table explaining each of the above presented **Permissions**:

| Permission             | Explanation |
| ---------------------- | ----------- |
| WRITE_EXTERNAL_STORAGE | Save Audio Files on the User's Device, in order to set sounds for `Alarm`, `Ringtone` and/or `Notifications`. |
| READ_EXTERNAL_STORAGE  | Create & Read from the App's Default Folder - No Access Given to Any Other Folder. |
| INTERNET               | Access the Internet & Download Audio Files. |