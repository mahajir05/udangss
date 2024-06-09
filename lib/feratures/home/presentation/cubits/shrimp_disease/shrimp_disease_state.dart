part of 'shrimp_disease_cubit.dart';

class ShrimpDiseaseState extends Equatable {
  final List<DiseaseEntity> shrimpDisease;
  final bool isLoading;
  final bool isError;
  final MetaDataApi? meta;

  const ShrimpDiseaseState({
    this.shrimpDisease = const [],
    this.isLoading = false,
    this.isError = false,
    this.meta,
  });

  ShrimpDiseaseState copyWith({
    List<DiseaseEntity>? shrimpDisease,
    bool? isLoading,
    bool? isError,
    MetaDataApi? meta,
  }) =>
      ShrimpDiseaseState(
        shrimpDisease: shrimpDisease ?? this.shrimpDisease,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        meta: meta ?? this.meta,
      );

  @override
  List<Object?> get props => [
        shrimpDisease,
        isLoading,
        isError,
        meta,
      ];
}
