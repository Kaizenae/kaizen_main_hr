// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:Attendace/core/services/location_services.dart';
import 'package:Attendace/core/utils/color_manager.dart';
import 'package:Attendace/core/utils/strings_manager.dart';
import 'package:Attendace/features/check-in_check-out/controller/bloc.dart';
import 'package:Attendace/features/check-in_check-out/controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/values_manager.dart';
import '../../../core/widgets/snack_bar/snack_bar_widget.dart';

class CheckInCheckOutScreen extends StatefulWidget {
  const CheckInCheckOutScreen({super.key});

  @override
  State<CheckInCheckOutScreen> createState() => _CheckInCheckOutScreenState();
}

class _CheckInCheckOutScreenState extends State<CheckInCheckOutScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  static Position? position;
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(
      position!.latitude,
      position!.longitude,
    ),
    tilt: 0.0,
    zoom: 17,
    bearing: 0.9,
  );
  Future<void> getCurrentLocation() async {
    await LocationServices.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> goToMyLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckInCheckOutBloc()
        ..getCompanyLocation()
        ..getLastChecking(),
      child: BlocConsumer<CheckInCheckOutBloc, CheckInCheckOutStates>(
        listener: (context, state) {
          if (state is CheckInCheckOutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                message: state.message.toString(), context: context));
            Navigator.pop(context);
          } else if (state is CheckInCheckOutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWidget(
                message: state.message.toString(), context: context));
          }
        },
        builder: (context, state) {
          return CheckInCheckOutBloc.get(context)
                      .checkInCheckOutModel
                      .result
                      .checking !=
                  null
              ? Stack(
                  children: [
                    SizedBox(
                      child: position != null
                          ? Stack(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: buildMap(),
                                ),
                                Positioned(
                                  top: MediaQuery.of(context).size.height / 5 -
                                      20,
                                  right: 20,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      goToMyLocation();
                                    },
                                    backgroundColor: ColorManager.darkPurple,
                                    child: const Icon(
                                      Icons.place,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.darkPurple,
                              ),
                            ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 5 * 1.4,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorManager.scaffoldColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.lightGrey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 3,
                                width: 60,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('dd, MMM yyyy')
                                            .format(DateTime.now()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: ColorManager.grey1,
                                            ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateFormat('hh : mm : ss')
                                                .format(DateTime.now()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(fontSize: 28),
                                          ),
                                          const SizedBox(
                                            width: AppSize.s12,
                                          ),
                                          Text(
                                            DateFormat('a')
                                                .format(DateTime.now()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(fontSize: 28),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "UTC/GMT +3 hours",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                color: ColorManager.grey1),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Text(
                                      //   "Al Reem Island - Najmat Abu Dhabi - Abu Dhabi",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .headlineMedium!
                                      //       .copyWith(
                                      //           color: ColorManager.grey1),
                                      //   textAlign: TextAlign.center,
                                      // ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              state is CheckInCheckOutLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (CheckInCheckOutBloc.get(
                                                              context)
                                                          .checkInCheckOutModel
                                                          .result
                                                          .checking !=
                                                      true) {
                                                    await CheckInCheckOutBloc
                                                            .get(context)
                                                        .checkDistance(
                                                            latitude: position!
                                                                .latitude,
                                                            longitude: position!
                                                                .longitude);
                                                    if (CheckInCheckOutBloc.get(
                                                            context)
                                                        .checked) {
                                                      CheckInCheckOutBloc.get(
                                                              context)
                                                          .checkInCheckOut();
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                            AppStrings
                                                                .YouAreOutSide,
                                                          ),
                                                          content: const Text(
                                                            AppStrings
                                                                .goToTheRequiredLocation,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  AppStrings
                                                                      .ok),
                                                            )
                                                          ],
                                                        ),
                                                        barrierDismissible:
                                                            false,
                                                      );
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      snackBarWidget(
                                                          message: AppStrings
                                                              .youAreAlreadyCheckingIn,
                                                          context: context),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  height: 110,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 14,
                                                    vertical: 16,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      26,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorManager
                                                            .lightGrey
                                                            .withOpacity(.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: CheckInCheckOutBloc
                                                                    .get(
                                                                        context)
                                                                .checkInCheckOutModel
                                                                .result
                                                                .checking ==
                                                            true
                                                        ? ColorManager.white
                                                        : ColorManager
                                                            .darkPurple,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppStrings.check_in,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                              color: CheckInCheckOutBloc.get(
                                                                              context)
                                                                          .checkInCheckOutModel
                                                                          .result
                                                                          .checking ==
                                                                      true
                                                                  ? ColorManager
                                                                      .lightGrey
                                                                  : ColorManager
                                                                      .white,
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "--:--",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                color: ColorManager
                                                                    .lightGrey),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (CheckInCheckOutBloc.get(
                                                              context)
                                                          .checkInCheckOutModel
                                                          .result
                                                          .checking ==
                                                      true) {
                                                    await CheckInCheckOutBloc
                                                            .get(context)
                                                        .checkDistance(
                                                            latitude: position!
                                                                .latitude,
                                                            longitude: position!
                                                                .longitude);
                                                    if (CheckInCheckOutBloc.get(
                                                            context)
                                                        .checked) {
                                                      CheckInCheckOutBloc.get(
                                                              context)
                                                          .checkInCheckOut();
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                            AppStrings
                                                                .YouAreOutSide,
                                                          ),
                                                          content: const Text(
                                                            AppStrings
                                                                .goToTheRequiredLocation,
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  AppStrings
                                                                      .ok),
                                                            )
                                                          ],
                                                        ),
                                                        barrierDismissible:
                                                            false,
                                                      );
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      snackBarWidget(
                                                          message: AppStrings
                                                              .youAreAlreadyCheckingOut,
                                                          context: context),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  height: 110,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 14,
                                                    vertical: 16,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      26,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorManager
                                                            .lightGrey
                                                            .withOpacity(.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: CheckInCheckOutBloc
                                                                    .get(
                                                                        context)
                                                                .checkInCheckOutModel
                                                                .result
                                                                .checking !=
                                                            true
                                                        ? ColorManager.white
                                                        : ColorManager
                                                            .darkPurple,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppStrings.check_out,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                              color: CheckInCheckOutBloc.get(
                                                                              context)
                                                                          .checkInCheckOutModel
                                                                          .result
                                                                          .checking !=
                                                                      true
                                                                  ? ColorManager
                                                                      .lightGrey
                                                                  : ColorManager
                                                                      .white,
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "--:--",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                color: ColorManager
                                                                    .lightGrey),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 110,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 14,
                                                  vertical: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      26,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorManager
                                                            .lightGrey
                                                            .withOpacity(.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: ColorManager.white),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Smoke breake start",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color: ColorManager
                                                                  .lightGrey),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "--:--",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                              color: ColorManager
                                                                  .lightGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 110,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 14,
                                                  vertical: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      26,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: ColorManager
                                                            .lightGrey
                                                            .withOpacity(.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    color: ColorManager.white),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Smoke breake End",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                            color: ColorManager
                                                                .lightGrey,
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "--:--",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                              color: ColorManager
                                                                  .lightGrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: ColorManager.darkPurple,
                        ),
                      ),
                    ),
                  ],
                )
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}
