import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/data_models/menu_item_model.dart';

class MenuItem extends StatelessWidget {
  final MenuItemModel item;
   const MenuItem({super.key,required this.item});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
      child: Row(
        children: [
          SvgPicture.asset(item.svgPath,height: 24,width: 24),SizedBox(width: 12,),
          Text(item.txt,style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: 16,
            color:item.color,
          ),)
        ],
      ),
    );
  }
}
