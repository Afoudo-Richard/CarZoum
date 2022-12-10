import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    this.isEditable = true,
    this.showEditIcon = true,
  }) : super(key: key);

  final bool isEditable;
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isEditable
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const SelectImageSourceDialog();
                },
              )
            : null;
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: 10.h,
                width: 20.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                    color: secondaryColor,
                  ),
                ),
                // child: Image.asset(
                //   'JunkIt_logo'.toPng,
                //   fit: BoxFit.cover,
                // ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: primaryColor,
                      color: secondaryColor,
                    ),
                  ),
                  imageUrl: state.user?.profileImage != null
                      ? state.user!.profileImage ?? ""
                      : "https://ui-avatars.com/api/?name=${state.user?.firstname}+${state.user?.lastname}",
                ),
              ),
              showEditIcon
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: BlocBuilder<UserImageBloc, UserImageState>(
                        builder: (context, state) {
                          return CustomCircle(
                            radius: 20.sp,
                            padding: EdgeInsets.all(1.sp),
                            color: primaryColor,
                            child:
                                state.userImageStatus == UserImageStatus.loading
                                    ? LoadingIndicator(
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 15.sp,
                                      ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
