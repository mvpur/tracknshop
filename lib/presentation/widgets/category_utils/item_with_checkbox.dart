import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';

class ItemWithCheckbox extends ConsumerStatefulWidget {
  final Item item;

  const ItemWithCheckbox({super.key, required this.item});

  @override
  ConsumerState<ItemWithCheckbox> createState() => _ItemWithCheckboxState();
}

class _ItemWithCheckboxState extends ConsumerState<ItemWithCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.item.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value ?? false;
          });

          ref
              .read(itemProvider.notifier)
              .updateItemCompletionStatus(widget.item.id, isChecked);
        },
      ),
      title: Text(
        widget.item.name,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
