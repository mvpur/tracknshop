import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/warehouse.dart';

class WarehouseItem extends StatelessWidget {
  const WarehouseItem({
    super.key,
    required this.warehouse,
    this.onTap,
  });

  final Warehouse warehouse;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: warehouse.icon,
        title: Text(warehouse.name),
        onTap: () => onTap?.call(),
      ),
    );
  }
}
