import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carzoum/carzoum.dart';

class ProfileHeaderUserInfo extends StatelessWidget {
  const ProfileHeaderUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            const UserProfileImage(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "${state.user?.firstname ?? "N/A"} ${state.user?.lastname ?? "N/A"}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              state.user?.email ?? "N/A",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              state.user?.phone ?? "N/A",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            CustomContainer(
              boxShadow: [],
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: Column(
                children: const [
                  ProfileUserItem(
                    icon: Icons.person,
                    title: 'Personal Details',
                  ),
                  ProfileUserItem(
                    icon: Icons.book,
                    title: 'My Records',
                  ),
                  ProfileUserItem(
                    icon: Icons.people,
                    title: 'Invite friends',
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
