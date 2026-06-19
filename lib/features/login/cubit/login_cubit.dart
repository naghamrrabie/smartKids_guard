// حط مسارات الـ Repo والـ States

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/login/cubit/login_state.dart';
import 'package:smartkids_gurad/features/login/domin/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit({required this.loginRepo}) : super(LoginInitial());

  Future<void> login(String phone, String password) async {
    emit(LoginLoading()); // بنبدأ بالـ Loading

    try {
      final response = await loginRepo.login(phone, password);
      await CacheHelper.saveData(key: 'token', value: response.token);
      await CacheHelper.saveData(key: 'refreshToken', value: response.refreshToken);
      emit(LoginSuccess(response)); // لو نجح
    } catch (e) {
      emit(LoginError(e.toString())); // لو حصل أي Exception اللي هندلناه في الـ Repo
    }
  }

}