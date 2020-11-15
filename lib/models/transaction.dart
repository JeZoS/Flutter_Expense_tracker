import 'package:flutter/material.dart';

class Transacton {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transacton({
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.title,
  });
}
