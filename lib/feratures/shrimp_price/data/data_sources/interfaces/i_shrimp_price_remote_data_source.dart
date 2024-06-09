import '../../../../../cores/models/base_resp.dart';
import '../../models/shrimp_price_model.dart';

abstract class IShrimpPriceRemoteDataSource {
  Future<BaseResp<ShrimpPriceModel>> getDetails(int id, int? regionId);
}
