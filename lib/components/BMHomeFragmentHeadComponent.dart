import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycycleclinic/utils/BMCommonWidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BMColors.dart';

class HomeFragmentHeadComponent extends StatelessWidget {
  final Function(int) onButtonPressed;

  HomeFragmentHeadComponent({required this.onButtonPressed});

  void handleButtonPress() {
    // Set the new selected tab value
    int newSelectedTab =
        3; // Example value, you can set it based on your requirements

    // Call the callback function to update the selected tab
    onButtonPressed(newSelectedTab);
  }

  String? userName = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return upperContainer(
      screenContext: context,
      child: Column(
        children: [
          40.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.amber, size: 50),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi',
                          style: boldTextStyle(color: Colors.white, size: 14)),
                      Text(
                        userName!.toUpperCase(),
                        style: boldTextStyle(color: Colors.white, size: 24),
                      ),
                      // Wrap(
                      //   children: [
                      //     Text('32',
                      //         style:
                      //             boldTextStyle(size: 24, color: Colors.white)),
                      //     Text(
                      //       '°C',
                      //       style: TextStyle(
                      //           fontFeatures: [FontFeature.superscripts()],
                      //           color: Colors.white),
                      //     )
                      //   ],
                      // )
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  handleButtonPress();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: radius(100)),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.person_2_outlined,
                    color: bmSpecialColorDark,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          16.height,
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: radius(32),
          //   ),
          //   padding: EdgeInsets.symmetric(horizontal: 8),
          //   child: AppTextField(
          //     decoration: InputDecoration(
          //         border: InputBorder.none,
          //         prefixIcon: Icon(Icons.search_sharp, color: bmPrimaryColor),
          //         hintText: 'Search your services..',
          //         hintStyle: boldTextStyle(color: bmPrimaryColor)),
          //     textFieldType: TextFieldType.NAME,
          //     cursorColor: bmPrimaryColor,
          //   ),
          // ),
          // 16.height,
        ],
      ),
    );
  }
}
