import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_dialog.dart';
import 'package:track_shop_app/presentation/screens/item/new_item_dialog.dart';

class AppSpeedDial extends StatelessWidget {
  final String heroTag;

  const AppSpeedDial({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      heroTag: heroTag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: Icons.add,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 12,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Item',
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return const NewItemDialog();
            },
          ),
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Category',
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return const NewCategoryDialog();
            },
          ),
        ),
      ],
    );
  }
}
