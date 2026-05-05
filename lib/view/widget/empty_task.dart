import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Theme;

import '../../res/colors.dart' show AppColors;

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center
        ,children: [
        Image.asset("assets/images/empty_state.png"),
        SizedBox(height: 20,),
        SizedBox(height: 75,width: 275,
          child: Column(
            children: [
              Text("No Tasks Yet",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,),textAlign: TextAlign.center,),
              Text("Get started by tapping the button below to create your first task",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textTitleBlack),textAlign: TextAlign.center,maxLines: 2)
            ],
          ),
        )

      ],
      ),
    );
  }
}
