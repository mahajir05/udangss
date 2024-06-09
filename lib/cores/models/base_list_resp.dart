class BaseListResp<T> {
  final List<T>? data;
  Map<String, dynamic>? meta;

  BaseListResp({
    this.data,
    this.meta,
  });

  BaseListResp.fromJson(dynamic json, Function fromJsonModel)
      : data = json['data'] != null
            ? List<T>.from(json['data'].cast<Map<String, dynamic>>().map((itemsJson) => fromJsonModel(itemsJson)))
            : null,
        meta = json['meta'];
}
