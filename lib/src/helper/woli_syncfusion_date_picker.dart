import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateRangeSelector extends StatefulWidget {
  const CustomDateRangeSelector({
    Key? key,
    required this.initialSelectedRange,
    required this.onChanged,
    required this.hintText,
    required this.isMultiple,
  }) : super(key: key);

  final PickerDateRange? initialSelectedRange;
  final ValueChanged<PickerDateRange?> onChanged;
  final bool? isMultiple;
  final String? hintText;

  @override
  _CustomDateRangeSelectorState createState() => _CustomDateRangeSelectorState();
}

class _CustomDateRangeSelectorState extends State<CustomDateRangeSelector> {
  PickerDateRange? initialSelectedRange;
  DateTime? initialSelectedSingle;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        final DateTime? value = args.value;
        initialSelectedRange = PickerDateRange(
          value,
          value,
        );
        widget.onChanged(initialSelectedRange);
      }
      if (args.value is PickerDateRange) {
        final PickerDateRange? value = args.value;
        initialSelectedRange = PickerDateRange(
          value?.startDate,
          value?.endDate ?? value?.startDate,
        );
        widget.onChanged(initialSelectedRange);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 700,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text("Pick date"),
          ),
        ),
        body: SfDateRangePicker(
          initialSelectedRange: initialSelectedRange,
          onSelectionChanged: _onSelectionChanged,
          selectionMode: widget.isMultiple! ? DateRangePickerSelectionMode.range : DateRangePickerSelectionMode.single,
          enableMultiView: true,
          yearCellStyle: const DateRangePickerYearCellStyle(
            textStyle: TextStyle(color: Colors.black),
          ),
          rangeTextStyle: const TextStyle(color: Colors.black),
          monthCellStyle: const DateRangePickerMonthCellStyle(
            textStyle: TextStyle(color: Colors.black),
          ),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(color: Color(0xFF0FBEB1)),
            ),
          ),
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(color: Colors.black),
          ),
          showActionButtons: true,
          cancelText: "Clear",
          confirmText: "Ok",
          onSubmit: (value) {
            print(value);
            Navigator.of(context, rootNavigator: true).pop();
            // widget.isMultiple!
            //     ? widget.onChanged(initialSelectedRange)
            //     : initialSelectedSingle = value;
            widget.onChanged(initialSelectedRange);
          },
          onCancel: () {
            setState(() {
              initialSelectedRange = const PickerDateRange(null, null);
            });
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
    );
  }
}
