import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final String formattedDate =
        DateFormat('dd/MM/yyyy').format(warehouse.date);
    return Card(
      child: ListTile(
        // leading: warehouse.icon,
        title: Text(warehouse.name.toString()),
        subtitle: Text('Date: $formattedDate'),
        onTap: () => onTap?.call(),
        trailing: IconButton(
          icon: const Icon(Icons.delete), // Ícono de eliminar
          onPressed: () {},
        ),
      ),
    );
  }
}
