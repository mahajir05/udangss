import '../../../../cores/configs/environment.dart';
import '../../../../cores/constants/api_path.dart';
import '../../../../cores/errors/error_utils.dart';
import '../../../../cores/models/base_list_resp.dart';
import '../../../../cores/services/api_service.dart';
import '../models/disease_model.dart';
import '../models/news_model.dart';
import '../models/region_model.dart';
import '../models/shrimp_price_model.dart';
import 'interfaces/i_home_remote_data_source.dart';

class HomeRemoteDataSource implements IHomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSource({required this.apiService});

  @override
  Future<BaseListResp<RegionModel>> getRegions(String keyword) async {
    final result = await apiService.baseUrl(Environment.baseUrl()).get(apiPath: ApiPath.getRegions(keyword));
    switch (result.statusCode) {
      case 200:
        return BaseListResp.fromJson(result.data, RegionModel.fromJson);
      default:
        return handleErrors(result);
    }
  }

  @override
  Future<BaseListResp<ShrimpPriceModel>> getShrimpPrices({int? page, int? perPage, int? regionId}) async {
    final result = await apiService
        .baseUrl(Environment.baseUrl())
        .get(apiPath: ApiPath.getShrimpPrices(perPage ?? 15, page ?? 1, regionId));
    switch (result.statusCode) {
      case 200:
        return BaseListResp.fromJson(result.data, ShrimpPriceModel.fromJson);
      default:
        return handleErrors(result);
    }
  }

  @override
  Future<BaseListResp<NewsModel>> getNews({int? page, int? perPage}) async {
    final result =
        await apiService.baseUrl(Environment.baseUrl()).get(apiPath: ApiPath.getNews(perPage ?? 15, page ?? 1));
    switch (result.statusCode) {
      case 200:
        return BaseListResp.fromJson(result.data, NewsModel.fromJson);
      default:
        return handleErrors(result);
    }
  }

  @override
  Future<BaseListResp<DiseaseModel>> getDiseases({int? page, int? perPage}) async {
    final result = await apiService
        .baseUrl(Environment.baseUrl())
        .tokenBearer(
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZiMzMxZmZhMzkxY2FjNWZmNDJhNjNlZWU3MjQzODQwY2RhNzIwYTc1ZDIwMzA3ZTU0MThiYjQ5ZDBjYmMyMGE5N2U3YTI5MjFhYmMyYTllIn0.eyJhdWQiOiIxIiwianRpIjoiZmIzMzFmZmEzOTFjYWM1ZmY0MmE2M2VlZTcyNDM4NDBjZGE3MjBhNzVkMjAzMDdlNTQxOGJiNDlkMGNiYzIwYTk3ZTdhMjkyMWFiYzJhOWUiLCJpYXQiOjE3MTMwMjk1ODAsIm5iZiI6MTcxMzAyOTU4MCwiZXhwIjoxNzQ0NTY1NTgwLCJzdWIiOiIxMzEyIiwic2NvcGVzIjpbXX0.RliuVHp7mGPc2Hyg8bURcXhfFYPEtosZMwrUb3jErdTtD2GpcZw0HzZ04fR3vtlg8OqIa8BSm_U72XJwABvt1MsYZMJ65HJV8HKvDg2IX7OQbjeG0hAtDfQV9pgPgKhk2F3S-7SQC0tg1rejwiW6xNJuMfYxH5l2djYlFLCFb5HrKjAg_2eH-GPDrqU3-idqzvFVpAu0sQnT465tQPFFPCH3kOizdevNDxUXs62iD0iOmG0A9RBaBC_JN37MRRAPDC8GlqiuEBVfznTkjBdMdx7zWh1-SPRDPytQv5vhIJpgEkatwYz7yTLp0swvlGQ31_-C8Tj8OrMVUrZfIWfFUdlzd11CaMsWkLj9PlKpjoCMt7cKwkzPDgLgDYkBQO0Tn7PAbqTfTYQUYJCbQuA1wzGfcA6w_oNeZRU2xP7mok0WbVlFCTlZnAxkt15a_XolE0Cyc9g6a_Z2afOb9YmN6lJDWa6rS-WCviPWBhbB8q2K3ww_4kxjowe1FTRiH-gto8fBFkbqjhbBBNXOZjwcjJqL3-dZMKCETXuk5BX53m4FTGKv-inT3bMYSVbCZHsoqgem0qEZE11u3MbviiJKEh5Vh07DK1nF6d07xCyUbObndgzfo7Y8aWuLofnAItqPyRa2r0KsaMszVH4yKvu43NXJ68ZlfoxEyWyX3zcWIa0",
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZiMzMxZmZhMzkxY2FjNWZmNDJhNjNlZWU3MjQzODQwY2RhNzIwYTc1ZDIwMzA3ZTU0MThiYjQ5ZDBjYmMyMGE5N2U3YTI5MjFhYmMyYTllIn0.eyJhdWQiOiIxIiwianRpIjoiZmIzMzFmZmEzOTFjYWM1ZmY0MmE2M2VlZTcyNDM4NDBjZGE3MjBhNzVkMjAzMDdlNTQxOGJiNDlkMGNiYzIwYTk3ZTdhMjkyMWFiYzJhOWUiLCJpYXQiOjE3MTMwMjk1ODAsIm5iZiI6MTcxMzAyOTU4MCwiZXhwIjoxNzQ0NTY1NTgwLCJzdWIiOiIxMzEyIiwic2NvcGVzIjpbXX0.RliuVHp7mGPc2Hyg8bURcXhfFYPEtosZMwrUb3jErdTtD2GpcZw0HzZ04fR3vtlg8OqIa8BSm_U72XJwABvt1MsYZMJ65HJV8HKvDg2IX7OQbjeG0hAtDfQV9pgPgKhk2F3S-7SQC0tg1rejwiW6xNJuMfYxH5l2djYlFLCFb5HrKjAg_2eH-GPDrqU3-idqzvFVpAu0sQnT465tQPFFPCH3kOizdevNDxUXs62iD0iOmG0A9RBaBC_JN37MRRAPDC8GlqiuEBVfznTkjBdMdx7zWh1-SPRDPytQv5vhIJpgEkatwYz7yTLp0swvlGQ31_-C8Tj8OrMVUrZfIWfFUdlzd11CaMsWkLj9PlKpjoCMt7cKwkzPDgLgDYkBQO0Tn7PAbqTfTYQUYJCbQuA1wzGfcA6w_oNeZRU2xP7mok0WbVlFCTlZnAxkt15a_XolE0Cyc9g6a_Z2afOb9YmN6lJDWa6rS-WCviPWBhbB8q2K3ww_4kxjowe1FTRiH-gto8fBFkbqjhbBBNXOZjwcjJqL3-dZMKCETXuk5BX53m4FTGKv-inT3bMYSVbCZHsoqgem0qEZE11u3MbviiJKEh5Vh07DK1nF6d07xCyUbObndgzfo7Y8aWuLofnAItqPyRa2r0KsaMszVH4yKvu43NXJ68ZlfoxEyWyX3zcWIa0")
        .get(apiPath: ApiPath.getDiseases(perPage ?? 15, page ?? 1));
    switch (result.statusCode) {
      case 200:
        return BaseListResp.fromJson(result.data, DiseaseModel.fromJson);
      default:
        return handleErrors(result);
    }
  }
}
