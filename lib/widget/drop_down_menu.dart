import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  final List<String> list;
  final ValueChanged<int> onItemSelected;

  const DropdownMenuExample({
    required this.list,
    required this.onItemSelected,
  });

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  int dropdownValue = 0;

  @override
  void initState() {
    super.initState();
    dropdownValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
          isExpanded: true,
          value: dropdownValue,
          borderRadius: BorderRadius.circular(8.0),
          onChanged: (int? value) {
            setState(() {
              dropdownValue = value!;
            });
            widget.onItemSelected(value!);
          },
          items: widget.list.asMap().entries.map<DropdownMenuItem<int>>((entry) {
            int index = entry.key;
            String value = entry.value;
            return DropdownMenuItem<int>(
              value: index,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}