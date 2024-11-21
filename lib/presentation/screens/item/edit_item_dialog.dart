import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/entities/type_amount.dart';

void showEditItemDialog(
  BuildContext context,
  WidgetRef ref,
  Item item,
) {
  final nameController = TextEditingController(text: item.name);
  final amountController = TextEditingController(text: item.amount?.toString());
  TypeAmount? selectedTypeAmount = TypeAmount.values.firstWhere(
      (type) => type.name == item.typeAmount,
      orElse: () => TypeAmount.unit);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<TypeAmount>(
              value: selectedTypeAmount,
              decoration: const InputDecoration(
                labelText: 'Select Unit',
                border: OutlineInputBorder(),
              ),
              items: TypeAmount.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                selectedTypeAmount = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newName = nameController.text.trim();
              final newAmount = double.tryParse(amountController.text.trim());

              if (newName.isNotEmpty && newAmount != null) {
                ref.read(itemProvider.notifier).updateItem(
                      item.id,
                      newName,
                      newAmount,
                      selectedTypeAmount?.name ?? '',
                    );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
