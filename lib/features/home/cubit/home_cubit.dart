import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/home/cubit/home_state.dart';
import 'package:smartkids_gurad/features/home/domin/home_repo.dart';
// استدعي الـ Repo والـ States والـ Model

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());

  Future<void> fetchChildren() async {
    emit(HomeLoading());
    try {
      final children = await homeRepo.getChildren();
      if (children.isNotEmpty) {
        CacheHelper.saveData(key: 'current_child_id', value: children[0].childId);
      }
      emit(HomeSuccess(children));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}