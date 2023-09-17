import 'package:equatable/equatable.dart';

class BalanceEntity extends Equatable {
  final int balance;

  const BalanceEntity({required this.balance});

  @override
  List<Object?> get props => [balance];
}
