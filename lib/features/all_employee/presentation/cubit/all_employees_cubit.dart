import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/employees_entity.dart';
import '../../domain/usecases/employees_usecase.dart';
import 'all_employees_state.dart';

class AllEmployeesCubit extends Cubit<AllEmployeesState> {
  final EmployeesUsecase employeeUsecase;

  AllEmployeesCubit({required this.employeeUsecase})
      : super(AllEmployeesInitial());

  static AllEmployeesCubit get(context) => BlocProvider.of(context);

  Future<void> getEmployeesFun() async {
    emit(GetEmployeesLoading());
    Either<Failure, EmployeesEntity> response =
        await employeeUsecase(NoParams());

    emit(response.fold((failure) => GetEmployeesError(message: failure.message),
        (employeeEntity) {
      return GetEmployeesSuccess(employeeEntity: employeeEntity);
    }));
  }
}
