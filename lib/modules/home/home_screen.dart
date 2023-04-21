import 'package:change_house_colors/modules/home/components/design_picker.dart';
import 'package:change_house_colors/modules/home/components/image_input_picker.dart';
import 'package:change_house_colors/modules/home/components/my_drawer.dart';
import 'package:change_house_colors/modules/home/components/num_of_result_picker.dart';
import 'package:change_house_colors/modules/home/components/step.dart';
import 'package:change_house_colors/modules/home/components/style_picker.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:change_house_colors/shared/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color(0xFFFFF6F0),
      appBar: MyAppBar(
        isHome: true,
        openDrawer: () {
          controller.openDrawer();
        },
      ),
      endDrawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "smart_ai_for_house_design".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xff002A9C),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: SingleChildScrollView(
              child: Column(children: [
                MyStep(
                  stepLabel: "choose_your_design".tr,
                  stepNum: 1,
                  child: const DesignPicker(),
                ),
                MyStep(
                  stepLabel: "upload_house_image".tr,
                  stepNum: 2,
                  child: const ImageInputPicker(),
                ),
                MyStep(
                  stepLabel: "select_style".tr,
                  stepNum: 3,
                  child: const StylePicker(),
                ),
                MyStep(
                    stepLabel: "choose_number_of_pictures".tr,
                    stepNum: 4,
                    child: const NumberOfResultPicker()),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(33))),
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.imageInput.value == null
                            ? null
                            : controller.startPredict,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33.0),
                          ),
                        ),
                        child: Text("generate_new_design".tr),
                      )),
                ),
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
