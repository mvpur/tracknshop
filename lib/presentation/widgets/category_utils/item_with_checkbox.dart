// lib/presentation/screens/item/item_with_checkbox.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/screens/item/delete_item_confirmation.dart';
import 'package:track_shop_app/presentation/screens/item/edit_item_dialog.dart';

class ItemWithCheckbox extends ConsumerWidget {
  final Item item;

  const ItemWithCheckbox({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = item.isCompleted;

    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) {
          final newValue = value ?? false;
          ref
              .read(itemProvider.notifier)
              .updateItemCompletionStatus(item.id, newValue);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showEditItemDialog(
                  context, ref, item); 
            },
            child: Text(
              item.name,
              style: TextStyle(
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showEditItemDialog(
                  context, ref, item); 
            },
            child: Text(
              item.amount != null && item.typeAmount != null
                  ? '${item.amount} - ${item.typeAmount?.toUpperCase()}'
                  : '—',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          IconButton(
            onPressed: () async {
              final confirm = await showDeleteConfirmationDialog(
                context: context,
                itemName: item.name,
              );

              if (confirm == true) {
                await ref.read(itemProvider.notifier).deleteItem(item.id);
              }
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
