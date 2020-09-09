import 'package:date_range_dropdown/src/models/date_picker_model.dart';
import 'package:flutter/material.dart';

class DateRangeDropdown extends StatefulWidget {
  final List<DatePickerModel> dates;
  final Function theme;
  final DateTime firstDate;
  final DateTime lastDate;
  final String hintText;
  final String initialValue;
  final Function onChanged;
  final Function callback;
  final Color dropdownIconColor;

  const DateRangeDropdown({
    Key key,
    @required this.dates,
    this.theme,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.initialValue,
    @required this.onChanged,
    @required this.callback,
    this.dropdownIconColor,
  }) : super(key: key);
  @override
  _DateRangeDropdownState createState() => _DateRangeDropdownState();
}

class _DateRangeDropdownState extends State<DateRangeDropdown> {
  var _selected;
  var _item;

  @override
  void initState() {
    _selected = widget.initialValue != null ? widget.initialValue : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        icon: Icon(
          Icons.arrow_drop_down,
          color: widget.dropdownIconColor != null
              ? widget.dropdownIconColor
              : Colors.blue,
        ),
        iconSize: 30,
        isExpanded: true,
        value: _selected,
        underline: SizedBox(),
        hint: Text(
          widget.hintText != null ? widget.hintText : 'Pick',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        focusColor: Theme.of(context).primaryColor,
        onChanged: (newValue) {
          FocusScope.of(context).unfocus();
          if (newValue != 'custom') {
            setState(() {
              _selected = newValue;
              _item =
                  widget.dates.firstWhere((element) => element.id == newValue);
            });
            widget.onChanged(_item);
          } else {
            datePicker(context);
          }
        },
        items: widget.dates.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            child: new Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            value: item.id,
          );
        }).toList(),
      ),
    );
  }

  Future<void> datePicker(_) async {
    final DateTimeRange picked = await showDateRangePicker(
      context: _,
      firstDate: widget.firstDate != null ? widget.firstDate : DateTime(1920),
      lastDate: widget.lastDate != null ? widget.lastDate : DateTime(2100),
      builder: widget.theme != null
          ? widget.theme
          : (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData(
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.accent),
                  accentColor: Colors.blue,
                  primaryColor: Colors.blue,
                ),
                child: child,
              );
            },
    );
    if (picked != null) {
      _selected = 'Custom';
      widget.callback(picked);
    }
  }
}
