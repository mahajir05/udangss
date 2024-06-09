part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final RegionEntity? selectedRegion;

  const FilterState({this.selectedRegion});

  FilterState copyWith({
    RegionEntity? selectedRegion,
  }) =>
      FilterState(selectedRegion: selectedRegion ?? this.selectedRegion);

  @override
  List<Object?> get props => [selectedRegion];
}
