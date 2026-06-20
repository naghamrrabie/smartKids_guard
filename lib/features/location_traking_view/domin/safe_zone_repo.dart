import 'package:dio/dio.dart';
import 'package:smartkids_gurad/features/location_traking_view/data/models/safe_zone_model.dart';

class SafeZoneRepo {
  final Dio dio;

  SafeZoneRepo({required this.dio});

  Future<List<SafeZoneModel>> getChildSafeZones(int childId) async {
    try {
      final response = await dio.get('/api/SafeZone/child/$childId');

      List<SafeZoneModel> zones = (response.data as List)
          .map((item) => SafeZoneModel.fromJson(item))
          .toList();

      return zones;
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      } else {
        throw 'لا يوجد اتصال بالإنترنت.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
  // ضيف الدالة دي جوه SafeZoneRepo
  Future<void> createSafeZone({
    required String name,
    required double lat,
    required double lng,
    required String type,
    required int childId,
  }) async {
    try {
      final response = await dio.post(
        '/api/SafeZone',
        data: {
          "name": name,
          "centerLatitude": lat,
          "centerLongitude": lng,
          "radius": 200, // ثابت زي ما السيرفر طالبه
          "type": type,
          "childId": childId
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw 'حدث خطأ أثناء الإضافة';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      } else {
        throw 'لا يوجد اتصال بالإنترنت.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
  // 💡 ضيف الدالة دي جوه SafeZoneRepo
  Future<void> deleteSafeZone(int id) async {
    try {
      final response = await dio.delete('/api/SafeZone/$id');

      if (response.statusCode != 200) {
        throw 'حدث خطأ أثناء المسح';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      } else {
        throw 'لا يوجد اتصال بالإنترنت.';
      }
    } catch (e) {
      throw 'حدث خطأ: ${e.toString()}';
    }
  }
}