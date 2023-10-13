import 'package:flutter/cupertino.dart';
import '../../../utils/constants.dart';

class TransactionEventMarker extends StatelessWidget {
  final DateTime date;
  final List events;

  const TransactionEventMarker({super.key, required this.date, required this.events});

  @override
  Widget build(BuildContext context) {
    double width = events.length < 100 ? 18 : 28;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromRGBO(67, 125, 229, 1),
      ),
      width: width,
      height: 18.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle().copyWith(
            color: AppColor.white,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}