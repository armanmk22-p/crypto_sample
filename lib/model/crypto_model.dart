import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CryptoModel extends Equatable {
  String? id;
  final int rank;
  final String symbol;
  final String name;
  final double priceUsd;
  final double changePercent24Hr;

  CryptoModel({
    this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.changePercent24Hr,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        rank: int.parse(json['rank']),
        priceUsd: double.parse(json['priceUsd']),
        changePercent24Hr: double.parse(json['changePercent24Hr']),
      );

  @override
  List<Object?> get props => [rank, symbol, name, priceUsd, changePercent24Hr];
}
