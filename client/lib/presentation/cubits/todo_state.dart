import 'package:app/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {}

class TodoInitial extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoSuccess extends TodoState {
  final List<TaskEntity> tasks;

  TodoSuccess({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TodoAdded extends TodoState {
  final TaskEntity task;

  TodoAdded({required this.task});

  @override
  List<Object?> get props => [task];
}

class TodoStatusChanged extends TodoState {
  TodoStatusChanged();

  @override
  List<Object?> get props => [];
}

class TodoFailure extends TodoState {
  final String exception;

  TodoFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
