import '../../../../../cores/models/base_list_resp.dart';
import '../../models/disease_model.dart';
import '../../models/news_model.dart';
import '../../models/region_model.dart';
import '../../models/shrimp_price_model.dart';

abstract class IHomeRemoteDataSource {
  Future<BaseListResp<RegionModel>> getRegions(String keyword);
  Future<BaseListResp<ShrimpPriceModel>> getShrimpPrices({int? page, int? perPage, int? regionId});
  Future<BaseListResp<NewsModel>> getNews({int? page, int? perPage});
  Future<BaseListResp<DiseaseModel>> getDiseases({int? page, int? perPage});
}
