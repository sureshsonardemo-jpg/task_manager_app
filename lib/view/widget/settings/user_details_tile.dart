import 'package:flutter/material.dart';
import 'package:task_manager_app/data_models/user_model.dart';
import 'package:task_manager_app/res/colors.dart';

class UserDetailsTile extends StatelessWidget {
   const UserDetailsTile({super.key,required this.currentUsr});
  final UserModel currentUsr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: ListTile(
        leading: Image.asset("assets/images/profile_image.png"),
        title: Text("${currentUsr.firstName} ${currentUsr.lastName}",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),),
        subtitle: Text(currentUsr.email,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14,color: AppColors.subTextGrey),),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_rounded))

      ),
    );
  }
}
