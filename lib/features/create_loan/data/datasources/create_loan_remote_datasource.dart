import 'package:Attendace/features/create_loan/data/models/get_currency_model.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/create_loan_model.dart';

abstract class CreateLoanRemoteDataSource {
  Future<CreateLoanModel> createLoan({
    required int userId,
    required double loanAmount,
    required int currencyId,
  });
  Future<GetCurrencyModel> getCurrency();
}

class CreateLoanRemoteDataSourceImpl implements CreateLoanRemoteDataSource {
  ApiConsumer apiConsumer;

  CreateLoanRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<CreateLoanModel> createLoan({
    required int userId,
    required double loanAmount,
    required int currencyId,
  }) async {
    final response =
        await apiConsumer.post(EndPoints.createLoanEndpoint, body: {
      "jsonrpc": "2.0",
      "params": {
        "user_id": userId,
        "loan_amount": loanAmount,
        "currency_id": currencyId,
      }
    });
    return CreateLoanModel.fromJson(response);
  }

  @override
  Future<GetCurrencyModel> getCurrency() async {
    final response = await apiConsumer
        .get(EndPoints.getCurrency, data: {"jsonrpc": "2.0", "params": {}});
    return GetCurrencyModel.fromJson(response);
  }
}
