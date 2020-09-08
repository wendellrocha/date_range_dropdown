import 'package:date_range_dropdown/date_range_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Range Dropdrown Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Date Range Dropdrown Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DatePickerModel> dates = List<DatePickerModel>();

  var _lastMonth = Jiffy().subtract(months: 1);
  DateTime _startDate = Jiffy().startOf(Units.DAY);
  DateTime _endDate = Jiffy().endOf(Units.DAY);
  String _selected = 'today';

  @override
  void initState() {
    dates.add(DatePickerModel.fromJson({
      "id": 'today',
      "title": "Today",
      "startDate": Jiffy().startOf(Units.DAY),
      "endDate": Jiffy().endOf(Units.DAY)
    }));

    dates.add(DatePickerModel.fromJson({
      "id": 'yesterday',
      "title": "Yesterday",
      "startDate": Jiffy().startOf(Units.DAY).subtract(Duration(days: 1)),
      "endDate": Jiffy().endOf(Units.DAY).subtract(Duration(days: 1))
    }));

    dates.add(DatePickerModel.fromJson({
      "id": 'last_7_days',
      "title": "Last 7 days",
      "startDate": Jiffy().startOf(Units.WEEK),
      "endDate": Jiffy().endOf(Units.WEEK)
    }));

    dates.add(DatePickerModel.fromJson({
      "id": 'last_30_days',
      "title": "Last 30 days",
      "startDate": Jiffy().startOf(Units.DAY).subtract(Duration(days: 30)),
      "endDate": Jiffy().endOf(Units.DAY)
    }));

    dates.add(DatePickerModel.fromJson({
      "id": 'last_month',
      "title": "Last month",
      "startDate": Jiffy(_lastMonth).startOf(Units.MONTH),
      "endDate": Jiffy(_lastMonth).endOf(Units.MONTH)
    }));

    dates.add(DatePickerModel.fromJson({
      "id": 'this_month',
      "title": "This month",
      "startDate": Jiffy().startOf(Units.MONTH),
      "endDate": Jiffy().endOf(Units.MONTH)
    }));

    dates.add(DatePickerModel.fromJson({
      "id": "custom",
      "title": "Custom",
      "startDate": DateTime.now(),
      "endDate": DateTime.now()
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              DateRangeDropdown(
                dates: dates,
                initialValue: _selected,
                theme: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData(
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.accent),
                      accentColor: Colors.red,
                      primaryColor: Colors.red,
                    ),
                    child: child,
                  );
                },
                dropdownIconColor: Colors.red,
                onChanged: (DatePickerModel value) => setState(
                  () {
                    _selected = value.id;
                    _startDate = value.startDate;
                    _endDate = value.endDate;
                  },
                ),
                callback: (DateTimeRange picked) => setState(
                  () {
                    _startDate = picked.start;
                    _endDate = picked.end;
                  },
                ),
              ),
              SizedBox(height: 6),
              Text('start: $_startDate, end: $_endDate, selected: $_selected')
            ],
          ),
        ),
      ),
    );
  }
}
