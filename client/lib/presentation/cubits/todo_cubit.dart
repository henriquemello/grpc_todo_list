import 'package:app/presentation/cubits/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetAllTasksUsecase getAllTasksUsecase;
  final CreateTaskUsecase createTaskUsecase;
  final BroadcastTasksUsecase broadcastTasksUsecase;
  final UpdateStatusUsecase updateStatusUsecase;

  TodoCubit({
    required this.getAllTasksUsecase,
    required this.createTaskUsecase,
    required this.broadcastTasksUsecase,
    required this.updateStatusUsecase,
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
    } catch (e) {
      emit(TodoFailure(exception: e.toString()));
    }
  }

  Future changeStatus({required TaskEntity task}) async {
    emit(TodoLoading());

    try {
      final newStatus = task.copyWith(done: !task.done);

      await updateStatusUsecase(task: newStatus);
      emit(TodoStatusChanged());
    } catch (e) {
      emit(TodoFailure(exception: e.toString()));
    }
  }

  Stream<List<TaskEntity>> broadcastTasks({required String id}) =>
      broadcastTasksUsecase.taskStream;
}
