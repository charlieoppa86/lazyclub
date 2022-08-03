import 'package:flutter/material.dart';
import 'package:lazyclub/components/providers/profile/profile_provider.dart';
import 'package:lazyclub/components/providers/profile/profile_state.dart';
import 'package:lazyclub/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;

  @override
  void initState() {
    super.initState();
    profileProv = context.read<ProfileProvider>();
    profileProv.addListener(errorDialogListener);
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener() {
    if (profileProv.state.profileStatus == ProfileStatus.error) {
      errorDialog(context, profileProv.state.error);
    }
  }

  @override
  void dispose() {
    profileProv.removeListener(errorDialogListener);
    super.dispose();
  }

  Widget _buildProfile() {
    final profileState = context.watch<ProfileProvider>().state;

    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Text('에러 발생!'),
      );
    }
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/logo_black.png',
              image: profileState.user.profileImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(children: [
                Text(
                  '- id : ${profileState.user.id}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '- name : ${profileState.user.name}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '- email : ${profileState.user.email}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '- point : ${profileState.user.createdAt}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildProfile(),
      ),
    );
  }
}
