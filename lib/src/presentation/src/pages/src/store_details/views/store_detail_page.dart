import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_formatter/money_formatter.dart';

class StoreDetailPage extends StatelessWidget {
  StoreDetailPage({
    Key? key,
  }) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => StoreDetailPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: "Store Details",
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: pagePadding,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, authState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<StoreDetailsBloc>(context)
                                        .add(
                                      StoreDetailsLogoSelected(
                                        imageSource: ImageSource.gallery,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 10.h,
                                    width: 20.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(
                                        color: secondaryColor,
                                      ),
                                    ),
                                    child: state.storeDetailsLogoStatus ==
                                            StoreDetailsLogoStatus.loading
                                        ? LoadingIndicator()
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: primaryColor,
                                                color: secondaryColor,
                                              ),
                                            ),
                                            imageUrl: authState.user?.store
                                                        ?.profileImage !=
                                                    null
                                                ? authState.user?.store!
                                                        .profileImage ??
                                                    ""
                                                : "https://ui-avatars.com/api/?name=${authState.user?.store?.name == null ? authState.user?.firstname : authState.user?.store?.name}",
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                1.h.ph,
                                CustomInput(
                                  inputInitialValue:
                                      authState.user?.store?.name,
                                  label: "Business Name",
                                  inputHintText: "Enter store name",
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                  labelTextStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  inputErrorText: state.storeName.invalid
                                      ? state.storeName.error
                                      : null,
                                  onChanged: (value) {
                                    BlocProvider.of<StoreDetailsBloc>(context)
                                        .add(StoreNameChanged(value));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                1.h.ph,
                                CustomInput(
                                  inputInitialValue:
                                      authState.user?.store?.location,
                                  label: "Location",
                                  inputHintText: "Enter location",
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                  labelTextStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  inputErrorText: state.storeLocation.invalid
                                      ? state.storeLocation.error
                                      : null,
                                  onChanged: (value) {
                                    BlocProvider.of<StoreDetailsBloc>(context)
                                        .add(StoreLocationChanged(value));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                1.h.ph,
                                CustomInput(
                                  inputInitialValue:
                                      authState.user?.store?.about,
                                  label: "About",
                                  inputHintText:
                                      "Short Description of your business",
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                  labelTextStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  inputErrorText: state.storeAbout.invalid
                                      ? state.storeAbout.error
                                      : null,
                                  onChanged: (value) {
                                    BlocProvider.of<StoreDetailsBloc>(context)
                                        .add(StoreAboutChanged(value));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                1.h.ph,
                                CustomInput(
                                  inputInitialValue:
                                      authState.user?.store?.about,
                                  label: "Phone",
                                  inputHintText: "Enter business phone number",
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                  labelTextStyle: TextStyle(
                                    color: primaryColor,
                                  ),
                                  inputErrorText: state.storeAbout.invalid
                                      ? state.storeAbout.error
                                      : null,
                                  onChanged: (value) {
                                    BlocProvider.of<StoreDetailsBloc>(context)
                                        .add(StoreAboutChanged(value));
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        3.h.ph,
                        BlocBuilder<StoreDetailsBloc, StoreDetailsState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: 100.w,
                              child: CustomButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  state.formStatus.isValidated
                                      ? BlocProvider.of<StoreDetailsBloc>(
                                              context)
                                          .add(StoreDetailsSubmitted())
                                      : BlocProvider.of<StoreDetailsBloc>(
                                              context)
                                          .add(StoreDetailsInputsChecked());
                                },
                                child: state.formStatus.isSubmissionInProgress
                                    ? LoadingIndicator(
                                        color: secondaryColor,
                                      )
                                    : Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
