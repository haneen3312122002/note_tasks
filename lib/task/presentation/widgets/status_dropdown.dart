import 'package:flutter/material.dart';

class StatusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const StatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.flag),
      ),
      items: const [
        DropdownMenuItem(value: 'pending', child: Text('Pending')),
        DropdownMenuItem(value: 'done', child: Text('Done')),
      ],
      onChanged: (val) => onChanged(val ?? 'pending'),
    );
  }
}
