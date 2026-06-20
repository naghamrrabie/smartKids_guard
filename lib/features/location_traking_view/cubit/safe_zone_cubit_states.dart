import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartkids_gurad/core/utils/cache_helper.dart';
import 'package:smartkids_gurad/features/location_traking_view/data/models/safe_zone_model.dart';
import 'package:smartkids_gurad/features/location_traking_view/domin/safe_zone_repo.dart';

abstract class SafeZoneState {}
class SafeZoneInitial extends SafeZoneState {}
class SafeZoneLoading extends SafeZoneState {}
class SafeZoneSuccess extends SafeZoneState {
  final List<SafeZoneModel> safeZones;
  SafeZoneSuccess(this.safeZones);
}
class SafeZoneError extends SafeZoneState {
  final String error;
  SafeZoneError(this.error);
}

class SafeZoneAddLoading extends SafeZoneState {}
class SafeZoneAddSuccess extends SafeZoneState {}
class SafeZoneAddError extends SafeZoneState {
  final String error;
  SafeZoneAddError(this.error);
}

// ... (باقي الـ States بتاعتك زي ما هي)

class SafeZoneDeleteLoading extends SafeZoneState {}
class SafeZoneDeleteSuccess extends SafeZoneState {
  final String message;
  SafeZoneDeleteSuccess(this.message);
}
class SafeZoneDeleteError extends SafeZoneState {
  final String error;
  SafeZoneDeleteError(this.error);
}

class SafeZoneCubit extends Cubit<SafeZoneState> {
  final SafeZoneRepo safeZoneRepo;

  SafeZoneCubit({required this.safeZoneRepo}) : super(SafeZoneInitial());

  Future<void> fetchSafeZones() async {
    emit(SafeZoneLoading());
    try {
      // 💡 بنجيب الـ ID من الكاش زي ما اتفقنا
      int? currentChildId = CacheHelper.getData(key: 'current_child_id');

      if (currentChildId == null) {
        emit(SafeZoneError("لا يوجد طفل مسجل لعرض مناطقه الآمنة."));
        return;
      }

      final zones = await safeZoneRepo.getChildSafeZones(currentChildId);
      emit(SafeZoneSuccess(zones));
    } catch (e) {
      emit(SafeZoneError(e.toString()));
    }
  }

  Future<void> addSafeZone({
    required String name,
    required double lat,
    required double lng,
    required String type,
  }) async {
    emit(SafeZoneAddLoading());
    try {
      int? currentChildId = CacheHelper.getData(key: 'current_child_id');
      if (currentChildId == null) {
        emit(SafeZoneAddError("لا يوجد طفل مسجل لإضافة المنطقة."));
        return;
      }

      await safeZoneRepo.createSafeZone(
        name: name,
        lat: lat,
        lng: lng,
        type: type,
        childId: currentChildId,
      );

      emit(SafeZoneAddSuccess());
      // بعد الإضافة نرجع نجيب الداتا من تاني عشان اللستة تتحدث
      fetchSafeZones();
    } catch (e) {
      emit(SafeZoneAddError(e.toString()));
    }
  }
  // 💡 ضيف الدالة دي جوه SafeZoneCubit
  Future<void> deleteSafeZone(int zoneId) async {
    emit(SafeZoneDeleteLoading());
    try {
      await safeZoneRepo.deleteSafeZone(zoneId);

      emit(SafeZoneDeleteSuccess('تم مسح المنطقة بنجاح!'));

      // نرجع نحدث الداتا من السيرفر عشان اللستة تتحدث في ساعتها
      fetchSafeZones();
    } catch (e) {
      emit(SafeZoneDeleteError(e.toString()));
    }
  }
}