import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  0.5.h.ph,
                  Text(
                    "${state.user?.firstname?.capitalizeFirst} ${state.user?.lastname?.capitalizeFirst}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  // FutureBuilder(
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.done) {
                  //       // If we got an error
                  //       if (snapshot.hasError) {
                  //         return Center(
                  //           child: Text(
                  //             '---------',
                  //             style: TextStyle(fontSize: 18),
                  //           ),
                  //         );

                  //         // if we got our data
                  //       }
                  //       // Extracting data from snapshot object
                  //       final data = snapshot.data;
                  //       return Text(
                  //         "${data?.firstname} ${data?.lastname}",
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //           fontSize: 18.sp,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       );
                  //     }
                  //     return LoadingIndicator();
                  //   },
                  //   future: BlocProvider.of<AuthenticationBloc>(context)
                  //       .state
                  //       .getUser(),
                  // ),
                ],
              ),
            ),
            const UserProfileImage(),
          ],
        );
      },
    );
  }
}
