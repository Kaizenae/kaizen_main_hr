import 'package:Attendace/features/create_loan/domain/entities/get_currency_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();
}

class CurrencyInitial extends CurrencyState {
  @override
  List<Object> get props => [];
}

class GetCurrencyLoading extends CurrencyState {
  @override
  List<Object> get props => [];
}

class GetCurrencySuccess extends CurrencyState {
  final GetCurrencyEntity getCurrencyEntity;

  const GetCurrencySuccess({required this.getCurrencyEntity});
  @override
  List<Object> get props => [];
}

class GetCurrencyError extends CurrencyState {
  final String message;

  const GetCurrencyError({required this.message});
  @override
  List<Object> get props => [];
}
