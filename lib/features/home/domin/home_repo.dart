import 'package:dio/dio.dart';
import 'package:smartkids_gurad/features/home/data/models/home_child_model.dart';

class HomeRepo {
  final Dio dio;

  HomeRepo({required this.dio});

  Future<List<HomeChildModel>> getChildren() async {
    try {
      final response = await dio.get('/api/Child/parent-children');

      List<HomeChildModel> children = (response.data as List)
          .map((child) => HomeChildModel.fromJson(child))
          .toList();

      return children;
    } on DioException catch (e) {
      if (e.response != null) {
        throw 'حدث خطأ في الخادم: ${e.response?.statusCode}';
      } else {
        throw 'تحقق من اتصالك بالإنترنت';
      }
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }
}