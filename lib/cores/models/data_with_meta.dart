import 'package:equatable/equatable.dart';

class DataWithMeta<T> extends Equatable {
  final T data;
  final Map<String, dynamic> _meta;

  MetaDataApi? get meta => MetaDataApi.fromJson(_meta);

  const DataWithMeta(this.data, this._meta);

  @override
  List<Object?> get props => [data, meta];
}

class MetaDataApi extends Equatable {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  const MetaDataApi({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

  factory MetaDataApi.fromJson(Map<String, dynamic> json) => MetaDataApi(
        currentPage: json['current_page'],
        from: json['from'],
        lastPage: json['last_page'],
        path: json['path'],
        perPage: (json['per_page'] is int?) ? json['per_page'] : int.tryParse(json['per_page'] ?? ""),
        to: json['to'],
        total: json['total'],
      );

  @override
  List<Object?> get props => [currentPage, from, lastPage, path, perPage, to, total];
}
