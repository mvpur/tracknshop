import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:intl/intl.dart';

class CatalogueItem extends StatelessWidget {
  const CatalogueItem({
    super.key,
    required this.catalogue,
    this.onTap,
  });

  final Catalogue catalogue;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy').format(catalogue.date);

    return Card(
      child: ListTile(
        //   leading: catalogue.icon,
        title: Text(catalogue.name.toString()),
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
