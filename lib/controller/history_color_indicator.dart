import 'package:flutter/material.dart';

abstract class IndicatorColorState {
  Color getColor();
}

class NewBookingColor implements IndicatorColorState {
  @override
  Color getColor() => Colors.red;
}

class AcceptedColor implements IndicatorColorState {
  @override
  Color getColor() => Colors.blue;
}

class AssignedColor implements IndicatorColorState {
  @override
  Color getColor() => Colors.orange;
}

class UnknownStateColor implements IndicatorColorState {
  @override
  Color getColor() => Colors.grey;
}

/////////
class IndicatorColorFactory {
  static final Map<String, IndicatorColorState> _indecatorColorMap = {
    'new booking': NewBookingColor(),
    'accepted': AcceptedColor(),
    'assigned': AssignedColor(),
  };

  static List<IndicatorColorState?> getStateColor(
      String newbook, String accepted, String assigned) {
    List<IndicatorColorState?> states = [
      _indecatorColorMap[newbook],
      _indecatorColorMap[accepted],
      _indecatorColorMap[assigned]
    ];
    return states;
  }
}
