import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VehicleSumary extends StatelessWidget {
  const VehicleSumary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: paddingSize),
          child: BlocBuilder<SellBloc, SellState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubItemTitle(
                    title: trans(context)!.vehicle_summary,
                    trailing: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VehicleSummaryItem(
                            title: trans(context)!.brand,
                            value: state.brand?.name?.capitalizeFirst ?? "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.model,
                            value: state.model?.name?.capitalizeFirst ?? "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.year_of_manufacture,
                            value: state.yearOfManufacture
                                    ?.toString()
                                    .capitalizeFirst ??
                                "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.fuel_type,
                            value:
                                state.fuelType?.name?.capitalizeFirst ?? "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.transmission_type,
                            value: state.transmissionType?.name ?? "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.vehicle_condition,
                            value: state.conditionType?.name ?? "N/A",
                          ),
                        ],
                      ),
                      10.w.pw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VehicleSummaryItem(
                            title: trans(context)!.mileage,
                            value: state.vehicleMileage.value.isNotEmpty
                                ? state.vehicleMileage.value.toString()
                                : "N/A",
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.location,
                            value: state.vehicleLocation.value.capitalizeFirst,
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.description,
                            value:
                                state.vehicleDescription.value.capitalizeFirst,
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.price,
                            value: state.vehiclePrice.value.capitalizeFirst,
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.vehicle_is_registered,
                            value:
                                state.isRegistered.toString().capitalizeFirst,
                          ),
                          2.h.ph,
                          VehicleSummaryItem(
                            title: trans(context)!.vehicle_price_is_negotiable,
                            value:
                                state.isNegotiable.toString().capitalizeFirst,
                          ),
                        ],
                      ),
                    ],
                  ),
                  4.h.ph,
                  SizedBox(
                    width: 100.w,
                    child: BlocBuilder<SellBloc, SellState>(
                      builder: (context, state) {
                        return CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<SellBloc>(context)
                                .add(VehicleSubmitted());
                          },
                          child: Text(
                            trans(context)!.proceed,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              letterSpacing: 1.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class VehicleSummaryItem extends StatelessWidget {
  const VehicleSummaryItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontSize: SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 5.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize:
                SizerUtil.deviceType == DeviceType.mobile ? 11.sp : 5.5.sp,
          ),
        ),
      ],
    );
  }
}
