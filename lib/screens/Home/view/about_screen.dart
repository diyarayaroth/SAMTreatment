import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/model/insurance_model.dart';
import 'package:health_care/screens/Home/view/home.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/function.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InsuranceAboutScreen extends StatefulWidget {
  final Rows providerElement;
  const InsuranceAboutScreen({super.key, required this.providerElement});
  @override
  State<InsuranceAboutScreen> createState() => _InsuranceAboutScreenState();
}

class _InsuranceAboutScreenState extends State<InsuranceAboutScreen> {
  RxString address = "".obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  @override
  void initState() {
    super.initState();
    CommonFunctions.checkConnectivity();
    lat.value = double.parse("${widget.providerElement.latitude}");
    long.value = double.parse("${widget.providerElement.longitude}");
  }

  Future<void> _showAddressDialog(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = placemarks[0];

      address.value =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppBar(
        isLeading: true,
        title: AppStrings.treatment,
      ),
      body: PrimaryPadding(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "${widget.providerElement.name1}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: AppColor.greyColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.call, color: Colors.black, size: 16),
                          horizontalSpacing(5),
                          // Text(" ${widget.providerElement.phone}",
                          //     style: AppTextStyle.regulerS14Black),
                          InkWell(
                            onTap: () {
                              // ignore: deprecated_member_use
                              launch("tel:${widget.providerElement.phone}");
                            },
                            child: Text(
                                " ${widget.providerElement.phone?.substring(0, 12)}",
                                style: AppTextStyle.regulerS14Black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.locationIcon,
                              height: 15, width: 15),
                          horizontalSpacing(5),
                          Text("${widget.providerElement.miles} Miles",
                              style: AppTextStyle.regulerS14Black),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language,
                              color: Colors.black, size: 16),
                          horizontalSpacing(5),
                          InkWell(
                            onTap: () {
                              // ignore: deprecated_member_use
                              launch("${widget.providerElement.website}");
                            },
                            child: SizedBox(
                              width: context.width * 0.7,
                              child: Text(
                                " ${widget.providerElement.website}",
                                style: AppTextStyle.regulerS14Black.copyWith(
                                  color: Colors.blue,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.black, size: 16),
                          horizontalSpacing(5),
                          SizedBox(
                            width: context.width * 0.7,
                            child: Text(
                              "${widget.providerElement.street1}, ${widget.providerElement.city}, ${widget.providerElement.state}, ${widget.providerElement.zip}",
                              style: AppTextStyle.regulerS14Black,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(10),
                  SizedBox(
                    height: context.height * 0.3,
                    width: double.infinity,
                    child: buildMap(lat.value, long.value, address.value),
                  ),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Image.asset(AppAsset.alertIcon, height: 15, width: 15),
                      horizontalSpacing(5),
                      SizedBox(
                        width: context.width * 0.8,
                        child: Text(
                            "This facility does not offer transportation assistance.",
                            style: AppTextStyle.regulerS14Black
                                .copyWith(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ],
                  ),
                  verticalSpacing(5),
                  const Divider(
                    thickness: 0.5,
                    color: AppColor.greyColor,
                  ),
                  verticalSpacing(10),
                  Row(
                    children: [
                      Image.asset((AppAsset.cardIcon), height: 20, width: 20),
                      horizontalSpacing(10),
                      SizedBox(
                        width: context.width * 0.8,
                        child: Text(
                            "Contact this facility to make sure they take your specific insurance or coverage.",
                            style: AppTextStyle.regulerS14Black
                                .copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ],
                  ),
                  verticalSpacing(15),
                  Row(
                    children: [
                      Image.asset((AppAsset.servicesIcon),
                          height: 20, width: 20),
                      horizontalSpacing(10),
                      SizedBox(
                        width: context.width * 0.8,
                        child: Text("Sevrvices",
                            style: AppTextStyle.appBarTextTitle.copyWith(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2),
                      ),
                    ],
                  ),
                  verticalSpacing(10),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.providerElement.services?.length ?? 0,
                      itemBuilder: (context, index) {
                        final service = widget.providerElement.services?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${service?.f1}",
                              style: AppTextStyle.regulerS14Black.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            verticalSpacing(5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset((AppAsset.rightIcon),
                                    height: 12, width: 12),
                                horizontalSpacing(5),
                                SizedBox(
                                  width: context.width * 0.8,
                                  child: Text(
                                    "${service?.f3}",
                                    style: AppTextStyle.regulerS14Black
                                        .copyWith(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpacing(10),
                            const Divider(
                              thickness: 0.5,
                              color: AppColor.greyColor,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            developedBy(),
          ],
        ),
      ),
    );
  }

  Widget buildMap(double lat, double long, String address) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, long),
        zoom: 14.0,
      ),
      markers: {
        Marker(
            markerId: const MarkerId("selected-location"),
            position: LatLng(lat, long),
            onTap: () => _showAddressDialog(LatLng(lat, long)),
            infoWindow: InfoWindow(
              title:
                  "${widget.providerElement.street1}, ${widget.providerElement.city}, ${widget.providerElement.state}, ${widget.providerElement.zip}",
            )),
      },
    );
  }
}
