import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_taxi_beta/constants/styles.dart';
import 'package:royal_taxi_beta/theme/app_theme.dart';
import 'package:royal_taxi_beta/widgets/stacked_shadow.dart';
import '../../../../widgets/buttons/bordered_button.dart';
import '../../../../widgets/snap_bar.dart';
import '../../../../widgets/svg_widget.dart';
import '../../../../widgets/textfields/rt_map_search_input.dart';
import '../../../widgets/cards/place_card.dart';

Future<void> showAddressPickBottomSheetModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              const StackedShadow(
                color: primaryColor,
              ),
              Positioned.fill(
                child: Card(
                  margin: EdgeInsets.zero,
                  color: darkColor,
                  elevation: 10.0,
                  shadowColor: blackColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SnapBar(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Svg(
                                path: "pin-2.svg",
                                size: 30.0,
                                color: primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  "03, Avenue Bismark Golf",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: whiteColor),
                                ).marginOnly(top: 4),
                              ),
                              const BorderedButton()
                            ],
                          ),
                          const DottedLine(
                            direction: Axis.vertical,
                            lineLength: 15.0,
                            lineThickness: 2.0,
                            dashColor: primaryColor,
                            dashLength: 6,
                          ).paddingLeft(13.0),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RTMapSearchField(
                                  borderColor: blackColor20,
                                ),
                              ),
                            ],
                          ).paddingTop(4.0),
                        ],
                      ).paddingHorizontal(10.0),
                      const DottedLine(
                        direction: Axis.horizontal,
                        lineThickness: .3,
                        dashLength: 4,
                      ).paddingVertical(10.0),
                      Expanded(
                          child: ListView.separated(
                        itemCount: 10,
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return const PlaceCard(
                            place: "Place Gare centrale",
                            reference: "Beatrice hôtel, palm beach, onatra",
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 8.0,
                        ),
                      ).paddingHorizontal(10.0)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

// placesAutoCompleteTextField() {
//   TextEditingController controller = TextEditingController();
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20),
//     child: GooglePlaceAutoCompleteTextField(
//       textEditingController: controller,
//       googleAPIKey: GoogleMapSettings.key,
//       inputDecoration: const InputDecoration(
//         hintText: "Search your location",
//         border: InputBorder.none,
//         enabledBorder: InputBorder.none,
//       ),
//       debounceTime: 400,
//       countries: ["in", "fr"],
//       isLatLngRequired: true,
//       getPlaceDetailWithLatLng: (Prediction prediction) {
//         print("placeDetails" + prediction.lat.toString());
//       },

//       itemClick: (Prediction prediction) {
//         controller.text = prediction.description ?? "";
//         controller.selection = TextSelection.fromPosition(
//             TextPosition(offset: prediction.description?.length ?? 0));
//       },
//       seperatedBuilder: Divider(),

//       containerHorizontalPadding: 10,

//       // OPTIONAL// If you want to customize list view item builder
//       itemBuilder: (context, index, Prediction prediction) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           child: Row(
//             children: [
//               Icon(Icons.location_on),
//               SizedBox(
//                 width: 7,
//               ),
//               Expanded(child: Text("${prediction.description ?? ""}"))
//             ],
//           ),
//         );
//       },

//       isCrossBtnShown: true,

//       // default 600 ms ,
//     ),
//   );
// }
