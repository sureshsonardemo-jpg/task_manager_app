import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/language_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/view/widget/search_field.dart';
import 'package:task_manager_app/view/widget/upper_bar/common_upper_bar.dart';

class LanguagePage extends StatefulWidget {
  LanguagePage({super.key});
  static const String route = "Language=page";

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final langController = Get.put(LanguageController());
  @override
  void dispose() {
    super.dispose();
    log("dispose called");
    langController.resetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 44),
            //Upper Bar
            CommonUpperBar(onBack: () => Get.back(), middleTxt: 'Languages'.tr),
            SizedBox(height: 28),
            Container(
              height: 48,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.homeBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SearchField(
                onChange: (value) {
                  langController.filterLanguages(value);
                },
                hinttext: "Search Languages...",
              ),
            ),
            Expanded(
              child: Obx(() =>GridView.builder(
                  shrinkWrap: true,
                  itemCount: langController.filteredLanguage.length,
                  //physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    // crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) => Obx(
                    () => GestureDetector(
                      onTap: () {
                        langController.currenLanguage.value =
                        langController.filteredLanguage[index];
                        langController.changeLanguage(langController.filteredLanguage[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              langController.currenLanguage.value ==
                                  langController.filteredLanguage[index]
                              ? AppColors.lightpurple
                              : Colors.transparent,
                          border: Border.all(
                            color:
                                langController.currenLanguage.value ==
                                    langController.filteredLanguage[index]
                                ? AppColors.purple
                                : AppColors.midGrey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          langController.filteredLanguage[index],
                          style:
                              langController.currenLanguage.value ==
                                  langController.filteredLanguage[index]
                              ? Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(fontSize: 14)
                              : Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
