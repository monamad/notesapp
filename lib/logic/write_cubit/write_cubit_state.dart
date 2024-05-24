part of 'write_cubit_cubit.dart';

@immutable
sealed class WriteCubitState {}

final class WriteCubitInitial extends WriteCubitState {}

final class WriteCubitLoading extends WriteCubitState {}

final class WriteCubitLoaded extends WriteCubitState {}

final class WriteCubitFailed extends WriteCubitState {
  final String error;
  WriteCubitFailed(this.error);
}
