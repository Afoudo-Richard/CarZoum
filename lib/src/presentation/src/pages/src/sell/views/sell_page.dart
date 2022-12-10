import 'dart:io';

import 'package:carzoum/src/presentation/src/global_widgets/src/search_input.dart';
import 'package:flutter/material.dart';
import 'package:carzoum/carzoum.dart';

import '../widgets/widgets.dart';

class SellPage extends StatelessWidget {
  const SellPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SellPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state.authenticated
            ? Scaffold(
                appBar: appBar(
                  title: trans(context)!.add_vehicle,
                  centerTitle: false,
                  actions: [
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<SellBloc>(context)
                            .add(VehicleSelectionCleared());
                      },
                      child: Text(
                        trans(context)!.clear,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                  automaticallyImplyLeading: false,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: pagePadding,
                    child: Column(
                      children: [
                        2.h.ph,
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trans(context)!.add_photo,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                // 2.h.ph,
                                // const Text(
                                //   "First picture - is the title picture.",
                                //   style: TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                                1.h.ph,
                                Row(children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<SellBloc>(context)
                                          .add(VehicleImagesSelected());
                                    },
                                    child: Column(
                                      children: [
                                        CustomCircle(
                                          radius: 45.sp,
                                          child: Icon(
                                            Icons.add,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // 1.h.ph,
                                        // Text(
                                        //   "Add photo",
                                        //   style: TextStyle(
                                        //     fontSize: 9.sp,
                                        //     color: primaryColor,
                                        //   ),
                                        // ),
                                        state.pickedPhotos.isNotEmpty
                                            ? Column(
                                                children: [
                                                  2.h.ph,
                                                  InkWell(
                                                    onTap: () {
                                                      BlocProvider.of<SellBloc>(
                                                              context)
                                                          .add(
                                                              VehicleClearAllVehiclePhotos());
                                                    },
                                                    child: Text(
                                                      "Clear photos",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                  2.w.pw,
                                  Expanded(
                                    child: SizedBox(
                                      height: 90,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: state.pickedPhotos.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            height: 80,
                                            width: 80,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: primaryColor,
                                            ),
                                            child: state.pickedPhotos != null
                                                ? Image(
                                                    image: FileImage(
                                                      File(state
                                                          .pickedPhotos[index]
                                                          .path),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )
                                                : const SizedBox.shrink(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                                1.h.ph,
                                Text(
                                  trans(context)!.supported_format_are,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        1.h.ph,
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.pickedPhotos.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        barrierColor:
                                            primaryColor.withOpacity(0.7),
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (ctx) {
                                          return AllBrands(
                                            onBrandItemTap: (brand) {
                                              BlocProvider.of<SellBloc>(context)
                                                  .add(
                                                VehicleBrandChanged(brand),
                                              );
                                            },
                                            selectedItem: state.brand,
                                          );
                                        },
                                      );
                                    },
                                    child: CustomInput(
                                      inputText: state.brand != null
                                          ? state.brand!.name
                                          : null,
                                      inputEnabled: false,
                                      label: trans(context)!.brand,
                                      inputHintText:
                                          trans(context)!.select_car_brand,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.7),
                                      labelTextStyle: const TextStyle(
                                        color: primaryColor,
                                      ),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: primaryColor,
                                        size: 20.sp,
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.brand != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return AllBrandModels(
                                                onModelItemTap: (model) {
                                                  BlocProvider.of<SellBloc>(
                                                          context)
                                                      .add(
                                                    VehicleModelChanged(model),
                                                  );
                                                },
                                                selectedItem: state.model,
                                              );
                                            },
                                          );
                                        },
                                        child: CustomInput(
                                          inputText: state.model != null
                                              ? state.model!.name
                                              : null,
                                          inputEnabled: false,
                                          label: trans(context)!.model,
                                          inputHintText: trans(context)!
                                              .select_brand_model,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          labelTextStyle: TextStyle(
                                            color: primaryColor,
                                          ),
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: primaryColor,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.model != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return AllBrandModelYears(
                                                onYearOfManufactureItemTap:
                                                    (yearOfManufacture) {
                                                  BlocProvider.of<SellBloc>(
                                                          context)
                                                      .add(
                                                    VehicleYearOfManufactureChanged(
                                                        yearOfManufacture),
                                                  );
                                                },
                                                selectedItem:
                                                    state.yearOfManufacture,
                                              );
                                            },
                                          );
                                        },
                                        child: CustomInput(
                                          inputText:
                                              state.yearOfManufacture != null
                                                  ? state.yearOfManufacture!
                                                      .toString()
                                                  : null,
                                          inputEnabled: false,
                                          label: trans(context)!
                                              .year_of_manufacture,
                                          inputHintText: trans(context)!
                                              .select_year_of_manufacture,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          labelTextStyle: TextStyle(
                                            color: primaryColor,
                                          ),
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: primaryColor,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.yearOfManufacture != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return AllFuelTypes(
                                                onFuelTypeItemTap: (fuelType) {
                                                  BlocProvider.of<SellBloc>(
                                                          context)
                                                      .add(
                                                    VehicleFuelTypeChanged(
                                                        fuelType),
                                                  );
                                                },
                                                selectedItem: state.fuelType,
                                              );
                                            },
                                          );
                                        },
                                        child: CustomInput(
                                          inputText: state.fuelType != null
                                              ? state.fuelType!.name
                                              : null,
                                          inputEnabled: false,
                                          label: trans(context)!.fuel_type,
                                          inputHintText:
                                              trans(context)!.select_fuel_type,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          labelTextStyle: TextStyle(
                                            color: primaryColor,
                                          ),
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: primaryColor,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.fuelType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return AllTransmissionTypes(
                                                onTransmissionTypeItemTap:
                                                    (transmissionType) {
                                                  BlocProvider.of<SellBloc>(
                                                          context)
                                                      .add(
                                                    VehicleTransmissionTypeChanged(
                                                      transmissionType,
                                                    ),
                                                  );
                                                },
                                                selectedItem:
                                                    state.transmissionType,
                                              );
                                            },
                                          );
                                        },
                                        child: CustomInput(
                                          inputText:
                                              state.transmissionType != null
                                                  ? state.transmissionType!.name
                                                  : null,
                                          inputEnabled: false,
                                          label:
                                              trans(context)!.transmission_type,
                                          inputHintText: trans(context)!
                                              .select_transmission_type,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          labelTextStyle: TextStyle(
                                            color: primaryColor,
                                          ),
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: primaryColor,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.transmissionType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return AllConditionTypes(
                                                onConditionTypeItemTap:
                                                    (conditionType) {
                                                  BlocProvider.of<SellBloc>(
                                                          context)
                                                      .add(
                                                    VehicleConditionTypeChanged(
                                                        conditionType),
                                                  );
                                                },
                                                selectedItem:
                                                    state.conditionType,
                                              );
                                            },
                                          );
                                        },
                                        child: CustomInput(
                                          inputText: state.conditionType != null
                                              ? state.conditionType!.name
                                              : null,
                                          inputEnabled: false,
                                          label:
                                              trans(context)!.vehicle_condition,
                                          inputHintText: trans(context)!
                                              .select_vehicle_condition,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.7),
                                          labelTextStyle: TextStyle(
                                            color: primaryColor,
                                          ),
                                          trailing: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: primaryColor,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      CustomInput(
                                        label: trans(context)!.vehicle_mileage +
                                            "(${trans(context)!.optional})",
                                        inputKeyBoardType: TextInputType.number,
                                        inputHintText: trans(context)!
                                            .enter_vehicle_mileage,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                        labelTextStyle: const TextStyle(
                                          color: primaryColor,
                                        ),
                                        inputErrorText:
                                            state.vehicleMileage.invalid
                                                ? state.vehicleMileage.error
                                                : null,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(
                                                  VehicleMileageChanged(value));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      CustomInput(
                                        label: trans(context)!.vehicle_location,
                                        inputHintText: trans(context)!
                                            .enter_vehicle_location,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                        labelTextStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        inputErrorText:
                                            state.vehicleLocation.invalid
                                                ? state.vehicleLocation.error
                                                : null,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(VehicleLocationChanged(
                                                  value));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      CustomInput(
                                        label: trans(context)!.vehicle_price +
                                            "(FCFA)",
                                        inputKeyBoardType: TextInputType.number,
                                        inputHintText:
                                            trans(context)!.enter_vehicle_price,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                        labelTextStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        inputErrorText:
                                            state.vehiclePrice.invalid
                                                ? state.vehiclePrice.error
                                                : null,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(VehiclePriceChanged(value));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Column(
                                    children: [
                                      1.h.ph,
                                      CustomInput(
                                        inputMaxLines: 5,
                                        label:
                                            trans(context)!.vehicle_description,
                                        inputHintText: trans(context)!
                                            .enter_vehicle_description,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.7),
                                        labelTextStyle: TextStyle(
                                          color: primaryColor,
                                        ),
                                        inputErrorText:
                                            state.vehicleDescription.invalid
                                                ? state.vehicleDescription.error
                                                : null,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(VehicleDescriptionChanged(
                                                  value));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        1.h.ph,
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Row(
                                    children: [
                                      Text(
                                        trans(context)!
                                            .is_this_vehicle_registered,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            primaryColor),
                                        value: state.isRegistered,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(VehicleIsRegisteredChanged(
                                                  value ?? false));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.conditionType != null
                                ? Row(
                                    children: [
                                      Text(
                                        trans(context)!.is_the_price_negotiable,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            primaryColor),
                                        value: state.isNegotiable,
                                        onChanged: (value) {
                                          BlocProvider.of<SellBloc>(context)
                                              .add(VehicleIsNegotiableChanged(
                                                  value ?? false));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        3.h.ph,
                        BlocBuilder<SellBloc, SellState>(
                          builder: (context, state) {
                            return state.brand != null &&
                                    state.model != null &&
                                    state.conditionType != null
                                ? SizedBox(
                                    width: 100.w,
                                    child: CustomButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        state.formStatus.isValidated
                                            ? showModalBottomSheet(
                                                barrierColor: primaryColor
                                                    .withOpacity(0.6),
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (ctx) {
                                                  return const VehicleSumary();
                                                },
                                              )
                                            : BlocProvider.of<SellBloc>(context)
                                                .add(
                                                    SubmitVehicleInputsChecked());
                                      },
                                      child: state
                                              .formStatus.isSubmissionInProgress
                                          ? LoadingIndicator(
                                              color: secondaryColor,
                                            )
                                          : Text(
                                              trans(context)!.next,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                        3.h.ph,
                      ],
                    ),
                  ),
                ),
              )
            : const LoginOrSignUp();
      },
    );
  }
}
