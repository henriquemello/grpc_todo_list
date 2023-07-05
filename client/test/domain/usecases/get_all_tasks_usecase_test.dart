import 'package:app/data/repositories/repositories.dart';
import 'package:app/domain/entities/entities.dart';
import 'package:app/domain/repositories/todo_repository.dart';
import 'package:app/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

class TodoRepositoryMock extends Mock implements TodoRepositoryImpl {}

void main() {
  late TodoRepository repository;
  late GetAllTasksUsecase usecase;
  final List<TaskEntity> listTaskMock = [];
  listTaskMock.addAll(List.generate(10, (index) => Mocks.taskMock));

  setUpAll(() {
    repository = TodoRepositoryMock();
    usecase = GetAllTasksUsecase(repository: repository);
    registerFallbackValue(Mocks.userMock);
  });



  test('should get all tasks from user', () async {
    //arrange
    when(
      () => repository.getTasks(any()),
    ).thenAnswer(
      (_) async => listTaskMock,
    );
    //act
    final result = await usecase(user: Mocks.userMock);
    //assert
    expect(result, listTaskMock);
    verify(() => repository.getTasks(any())).called(1);
    
  });
}
