class ApiPath {
  static String getShrimpPrices(int perPage, int page, int? regionId) =>
      "/shrimp_prices?per_page=$perPage&page=$page&with=region,creator&region_id=${regionId == null ? '' : regionId.toString()}";
  static String getDetailShrimpPrice(int id, int? regionId) =>
      "/shrimp_prices/$id?with=region,creator&region_id=${regionId == null ? '' : regionId.toString()}";

  static String getRegions(String keyword) => "/regions?has=shrimp_prices&search=$keyword";

  static String getNews(int perPage, int page) => "/posts?per_page=$perPage&page=$page&with=creator";

  static String getDiseases(int perPage, int page) => "/diseases?per_page=$perPage&page=$page";
}
