import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controller/language_controller.dart';
import 'package:task_manager_app/res/colors.dart' show AppColors;
import 'package:task_manager_app/view/widget/search_field.dart';
import 'package:task_manager_app/view/widget/upper_bar/common_upper_bar.dart';

class LanguagePage extends StatelessWidget {
  final List<String> listOfLanguage=[
    "Hindi","English","Gujarati","Marathi","Bengali","Punjabi","Tamil","Telugu","Malayalam","Kannada","Urdu","Odia","Assamese","Sanskrit","Nepali","Bhojapuri",
  ];

   LanguagePage({super.key});
  static const String route = "Language=page";
  final searchController = TextEditingController();
  final langController=Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 44),
            //Upper Bar
            CommonUpperBar(onBack: () => Get.back(),middleTxt: 'Languages'.tr),
            SizedBox(height: 28),
            Container(
              height: 48,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.homeBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SearchField(
                controller: searchController,
                hinttext: "Search Languages...",
              ),
            ),
            GridView.builder(shrinkWrap: true,itemCount: listOfLanguage.length,physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3,crossAxisSpacing: 12,mainAxisSpacing: 16),
              itemBuilder: (context, index) => Obx(() => GestureDetector(
                onTap: () {
                  langController.currenLanguage.value=listOfLanguage[index];
                  langController.changeLanguage(listOfLanguage[index]);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: langController.currenLanguage.value==listOfLanguage[index]?AppColors.lightpurple:Colors.transparent,
                      border: Border.all(color: langController.currenLanguage.value==listOfLanguage[index]?AppColors.purple:AppColors.midGrey,),
                      borderRadius: BorderRadius.circular(8)
                    ),alignment: Alignment.center
                    ,child: Text(listOfLanguage[index],
                style: langController.currenLanguage.value==listOfLanguage[index]
                    ? Theme.of(context).textTheme.titleLarge!.copyWith( fontSize: 14,)
                    : Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14)),  ),
              ),
              ),),
          ],
        ),
      ),
    );
  }
}
