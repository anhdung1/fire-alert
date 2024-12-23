import 'dart:math';
import 'dart:ui';

import 'package:alert_app/constant/colors_widget.dart';
import 'package:flutter/material.dart';

behavior(BuildContext context) {
  return ScrollConfiguration.of(context).copyWith(
      dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch});
}

submitButton(onTap, double width, String nameButton) {
  return Builder(builder: (context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width / 9,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: ColorsWidget.iconColor),
        child: Text(
          nameButton,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 23,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  });
}

inputText(String hintext, bool obscureText, controller) {
  return Builder(builder: (context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.center,
        height: screenWidth / 9,
        // margin: EdgeInsets.only(bottom: screenWidth / 25),
        decoration: BoxDecoration(
            color: ColorsWidget.backgroundColorTextField,
            borderRadius: BorderRadius.circular(7)),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: ColorsWidget.hinTextColor, fontSize: screenWidth / 25),
              hintText: hintext,
              contentPadding: const EdgeInsets.only(left: 15),
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ));
  });
}

Widget search(
    TextEditingController controller, Function() onTap, screenHeight) {
  return Row(
    children: [
      Expanded(
        child: Container(
            alignment: Alignment.center,
            height: screenHeight / 16,
            decoration: BoxDecoration(
                color: ColorsWidget.backgroundColorTextField,
                borderRadius: BorderRadius.circular(7)),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                onTap();
              },
              decoration: InputDecoration(
                  prefixIcon: Transform.rotate(
                    angle: pi / 2,
                    child: const Icon(Icons.search_rounded),
                  ),
                  hintStyle: TextStyle(
                      color: ColorsWidget.hinTextColor,
                      fontSize: screenHeight / 45),
                  hintText: "Search",
                  contentPadding: const EdgeInsets.only(left: 15),
                  border:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            )),
      ),
      const SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: onTap,
        child: Icon(
          Icons.filter_list_rounded,
          size: screenHeight / 20,
        ),
      )
    ],
  );
}

loading() {
  return Builder(builder: (context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  });
}
