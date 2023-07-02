import 'package:app/presentation/cubits/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetAllTasksUsecase getAllTasksUsecase;
  final CreateTaskUsecase createTaskUsecase;

  TodoCubit({
    required this.getAllTasksUsecase,
    required this.createTaskUsecase,
  }) : super(TodoInitial());

  Future getTasksFromUser({required String id}) async {
    emit(TodoLoading());

    try {
      final tasks = await getAllTasksUsecase(user: UserEntity(id: id));

      emit(TodoSuccess(tasks: tasks));
    } catch (e) {
      emit(TodoFailure(exception: e.toString()));
    }
  }

  Future createTask({required TaskEntity task}) async {
    emit(TodoLoading());

    try {
      final taskAdded = await createTaskUsecase(task);
      emit(TodoAdded(task: taskAdded));
      getTasksFromUser(id: "mello");
    } catch (e) {
      emit(TodoFailure(exception: e.toString()));
    }
  }
}
