import 'package:flutter/material.dart';
import 'package:homework_one/local_notifications.dart';
import 'package:shake/shake.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => My_NotificationsState();
}

class My_NotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(
      onPhoneShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            content: Text('You shaked the phone!'),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("HW-4"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 32),
              // height: 32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "NOTE: only in this page, you can shake the phone and see what happens!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Notification type 1: This notification will pop after clicking right on it, which means when the app is on the foreground.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  LocalNotifications.showSimpleNotification(
                      title: 'Hey', body: 'Test notifications', payLoad: '100');
                },
                icon: Icon(Icons.notifications),
                label: Text("My simple notification")),
            SizedBox(height: 24),
            Divider(),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Notification type 2: This notification will pop even when the application is not on the foreground.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  await LocalNotifications.showNotification2Periodic(
                      title: "Minutely",
                      body: 'You will see this notif every minute',
                      payLoad: 'Payload');
                  final snackBar = SnackBar(
                    content: Text(
                        'You will get a notifiaction in a minute. You can get out of the application to see that it will also work when the application is not on the foreground.'),
                    duration: Duration(seconds: 10), // Optional duration
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        // Some action to take when the user presses the action button
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: Icon(Icons.notifications_active_outlined),
                label: Text('My periodic notification')),
            ElevatedButton.icon(
                onPressed: () {
                  LocalNotifications.cancel(1);
                },
                icon: Icon(Icons.cancel),
                label: Text("Cancel the periodic notification")),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "*Note 1: This button is to cancel the periodic notification. The reason for existance of such button is to cancel the minutely notification because if it is not canceled, it will give you a notification every minute and it will stop UNLESS you uninstall the application."),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "*Note 2: Both notifications have the interaction that when you click on them, the application opens."),
            )
          ]),
        ),
      ),
    );
  }
}
