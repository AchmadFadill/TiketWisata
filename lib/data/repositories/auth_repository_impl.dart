import '../datasources/auth_remote_datasources.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

@override
Future<Map<String, dynamic>> login(String email, String password){
    return remoteDatasource.login(email, password);
}
}