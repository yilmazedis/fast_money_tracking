import 'package:fast_money_tracking/pages/calendar_pages/widgets/balance.dart';
import 'package:fast_money_tracking/pages/calendar_pages/widgets/transaction_event_marker.dart';
import 'package:fast_money_tracking/pages/calendar_pages/widgets/transaction_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/item_controller.dart';
import '../../localization/methods.dart';
import '../../models/item.dart';
import '../../utils/constants.dart';
import '../../widgets/classes/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  final ItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.blue1,
        appBar: BasicAppBar(title: getTranslated(context, 'Calendar')),
        body: Obx(() => CalendarBody(items: controller.items.value)));
  }
}

class CalendarBody extends StatefulWidget {
  final List<Item> items;

  const CalendarBody({required this.items, super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // Can be toggled on/off by longPressing a date
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? _selectedDay, _rangeStart, _rangeEnd;
  late Map<DateTime, List<Item>> transactions = {};
  late ValueNotifier<List<Item>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Item>> map = {};
    final items = widget.items;
    if (widget.items.isNotEmpty) {
      for (int i = 0; i < items.length; i++) {
        Item map1 = Item(
            id: items[i].id,
            type: items[i].type,
            amount: items[i].amount,
            category: items[i].category,
            description: items[i].description,
            date: items[i].date);

        void updateMapValue<K, V>(Map<K, List<V>> map, K key, V value) => map
            .update(key, (list) => list..add(value), ifAbsent: () => [value]);

        updateMapValue(
          map,
          items[i].date.split(" ").first,
          map1,
        );
      }
      transactions = map.map(
          (key, value) => MapEntry(DateFormat("dd-MM-yyyy").parse(key), value));
    }

    late LinkedHashMap linkedHashedMapTransactions =
        LinkedHashMap<DateTime, List<Item>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(transactions);

    List<Item> transactionsForDay(DateTime? day) =>
        linkedHashedMapTransactions[day] ?? [];

    if (_selectedDay != null) {
      _selectedEvents = ValueNotifier(transactionsForDay(_selectedDay));
    }

    List<Item> _getEventsForRange(DateTime start, DateTime end) {
      final days = daysInRange(start, end);

      return [
        for (final d in days) ...transactionsForDay(d),
      ];
    }

    void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      if (!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _rangeStart = null; // Important to clean those
          _rangeEnd = null;
          _rangeSelectionMode = RangeSelectionMode.toggledOff;
        });
        _selectedEvents.value = transactionsForDay(selectedDay);
      }
    }

    void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
      setState(() {
        _selectedDay = null;
        _focusedDay = focusedDay;
        _rangeStart = start;
        _rangeEnd = end;
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
        if (start != null && end != null) {
          _selectedEvents = ValueNotifier(_getEventsForRange(start, end));
        } else if (start != null) {
          _selectedEvents = ValueNotifier(transactionsForDay(start));
        } else if (end != null) {
          _selectedEvents = ValueNotifier(transactionsForDay(end));
        }
      });
    }

    return Column(children: [
      TableCalendar<Item>(

        availableCalendarFormats: {
          CalendarFormat.month: getTranslated(context, 'Month'),
          CalendarFormat.twoWeeks: getTranslated(context, '2 weeks'),
          CalendarFormat.week: getTranslated(context, 'Week')
        },
        locale: Localizations.localeOf(context).languageCode,
        // sixWeekMonthsEnforced: true,
        // shouldFillViewport: true,
        rowHeight: 52,
        daysOfWeekHeight: 22,
        firstDay: DateTime.utc(2000, 01, 01),
        lastDay: DateTime.utc(2070, 01, 01),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        rangeSelectionMode: _rangeSelectionMode,
        eventLoader: transactionsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          weekendTextStyle: const TextStyle().copyWith(color: Colors.blue[800]),
        ),

        headerStyle: HeaderStyle(
          formatButtonTextStyle: const TextStyle(fontSize: 18),
          formatButtonDecoration: BoxDecoration(
              boxShadow: const [BoxShadow()],
              color: AppColor.blue2,
              borderRadius: BorderRadius.circular(25)),
        ),
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, _) {
            return Container(
              //see difference between margin and padding below: Margin: Out (for itself), padding: In (for its child)
              // margin: EdgeInsets.all(4.0.w),
              padding: const EdgeInsets.only(top: 6.0, left: 6.0),
              color: AppColor.orange2,
              width: 46,
              height: 46,
              child: Text(
                '${date.day}',
                style: const TextStyle().copyWith(fontSize: 17.0),
              ),
            );
          },
          todayBuilder: (context, date, _) {
            return Container(
              padding: const EdgeInsets.only(top: 6.0, left: 6.0),
              color: AppColor.blue2,
              width: 46,
              height: 46,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 17.0),
              ),
            );
          },
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                right: 1,
                bottom: 1,
                child: TransactionEventMarker(date: date, events: events),
              );
            }
          },
        ),

        onDaySelected: _onDaySelected,
        onRangeSelected: _onRangeSelected,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        pageJumpingEnabled: true,
      ),
      const SizedBox(height: 8.0),
      Expanded(
        child: ValueListenableBuilder<List<Item>>(
          valueListenable: _selectedEvents,
          builder: (context, value, _) {
            print(value.length);
            return Column(children: [
              Balance(items: value),
              Expanded(child: TransactionEvents(transactions: value))
            ]);
          },
        ),
      )
    ]);
  }
}