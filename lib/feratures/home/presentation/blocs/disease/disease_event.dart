part of 'disease_bloc.dart';

sealed class DiseaseEvent extends Equatable {
  const DiseaseEvent();

  @override
  List<Object?> get props => [];
}

class DiseaseGetEvent extends DiseaseEvent {
  final int? perPage;
  final int? page;

  const DiseaseGetEvent({required this.perPage, required this.page});

  @override
  List<Object?> get props => [perPage, page];
}
