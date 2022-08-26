import 'package:flutter/material.dart';
import 'package:project/classes/navigationBar.dart';
import 'package:project/classes/userClass.dart';
import 'package:project/util/styles.dart';
import 'package:project/views/profileCommon.dart';

import '../classes/firestoreFunctions.dart';
import '../views_initial/errorScreen.dart';
import '../views_initial/waitingScreen.dart';

class MediaProfileView extends StatefulWidget {
  final UserData user;
  final bool isPrivateProfile;

  MediaProfileView(
      {Key? key, required this.user, required this.isPrivateProfile})
      : super(key: key);

  @override
  State<MediaProfileView> createState() => _MediaProfileViewState();
}

class _MediaProfileViewState extends State<MediaProfileView> {
  late Stream<UserData> streamer;

  @override
  void initState() {
    streamer = readUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: streamer,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen(message: snapshot.toString());
          }
          if (!snapshot.hasData) {
            return const WaitingScreen();
          } else {
            final userNew = snapshot.data!;
            return SafeArea(
              child: Row(children: [
                const NavBar(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileCommon(user: widget.user),
                      !widget.isPrivateProfile
                          ? const Text("Media")
                          : Center(
                              child: Text(
                              "\nThis profile is private",
                              style: kAppBarTitleTextStyle,
                            )),
                    ],
                  ),
                ),
              ]),
            );
          }
        });
  }
}
