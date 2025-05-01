import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiket_wisata/data/datasources/auth_local_datasources.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecase/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final AuthLocalDataSource authLocalDataSource; // ✅ Tambahkan ini

  AuthBloc(this.loginUseCase, this.authLocalDataSource) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);

        final user = result['user'];
        final token = result['token'];

        // ✅ Simpan token secara lokal
        await authLocalDataSource.saveToken(token);

        emit(AuthSuccess(user, token));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
