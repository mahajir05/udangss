part of 'regions_bloc.dart';

sealed class RegionsEvent extends Equatable {
  const RegionsEvent();

  @override
  List<Object?> get props => [];
}

class RegionsSearchEvent extends RegionsEvent {
  final String keyword;

  const RegionsSearchEvent({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}
