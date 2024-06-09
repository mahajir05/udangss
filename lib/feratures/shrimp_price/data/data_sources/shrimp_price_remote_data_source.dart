import '../../../../cores/configs/environment.dart';
import '../../../../cores/constants/api_path.dart';
import '../../../../cores/errors/error_utils.dart';
import '../../../../cores/models/base_resp.dart';
import '../../../../cores/services/api_service.dart';
import '../models/shrimp_price_model.dart';
import 'interfaces/i_shrimp_price_remote_data_source.dart';

class ShrimpPriceRemoteDataSource implements IShrimpPriceRemoteDataSource {
  final ApiService apiService;

  ShrimpPriceRemoteDataSource({required this.apiService});

  @override
  Future<BaseResp<ShrimpPriceModel>> getDetails(int id, int? regionId) async {
    final result =
        await apiService.baseUrl(Environment.baseUrl()).get(apiPath: ApiPath.getDetailShrimpPrice(id, regionId));
    switch (result.statusCode) {
      case 200:
        return BaseResp.fromJson(result.data, ShrimpPriceModel.fromJson);
      default:
        return handleErrors(result);
    }
  }
}
