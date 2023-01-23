import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'popup_cell.dart';

class PlutoDateCell extends StatefulWidget implements PopupCell {
  @override
  final PlutoGridStateManager stateManager;

  @override
  final PlutoCell cell;

  @override
  final PlutoColumn column;

  @override
  final PlutoRow row;

  const PlutoDateCell({
    required this.stateManager,
    required this.cell,
    required this.column,
    required this.row,
    Key? key,
  }) : super(key: key);

  @override
  PlutoDateCellState createState() => PlutoDateCellState();
}

class PlutoDateCellState extends State<PlutoDateCell> with PopupCellState<PlutoDateCell> {
  PlutoGridStateManager? popupStateManager;

  @override
  List<PlutoColumn> popupColumns = [];

  @override
  List<PlutoRow> popupRows = [];

  @override
  IconData? get icon => widget.column.type.date.popupIcon;

  @override
  void openPopup() {
    if (widget.column.checkReadOnly(widget.row, widget.cell)) {
      Clipboard.setData(
        ClipboardData(
          text: widget.cell.value == "" ? "-" : widget.cell.value,
        ),
      );
      Flushbar(
        message: "The text has been copied!",
        backgroundColor: const Color(0xFF0FBEB1),
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.yellow,
        ),
        margin: const EdgeInsets.all(6.0),
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        textDirection: Directionality.of(context),
        borderRadius: BorderRadius.circular(12),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color.fromARGB(67, 15, 190, 178),
      ).show(context);
      return;
    }

    isOpenedPopup = true;

    PlutoGridDatePicker(
      context: context,
      initDate: PlutoDateTimeHelper.parseOrNullWithFormat(
        widget.cell.value,
        widget.column.type.date.format,
      ),
      startDate: widget.column.type.date.startDate,
      endDate: widget.column.type.date.endDate,
      dateFormat: widget.column.type.date.dateFormat,
      headerDateFormat: widget.column.type.date.headerDateFormat,
      onSelected: onSelected,
      itemHeight: widget.stateManager.rowTotalHeight,
      configuration: widget.stateManager.configuration,
    );
  }
}
