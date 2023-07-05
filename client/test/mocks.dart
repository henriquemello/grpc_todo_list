import 'package:app/config/app_constants.dart';
import 'package:app/domain/entities/entities.dart';
import 'package:faker/faker.dart';

class Mocks {
  static TaskEntity get taskMock => TaskEntity(
      id: faker.guid.toString(),
      done: faker.internet.random.boolean(),
      owner: const UserEntity(id: AppConstants.USER_NAME),
      title: faker.internet.random.string(10));

  static UserEntity get userMock => const UserEntity(id: AppConstants.USER_NAME);
}
