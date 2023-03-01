part of 'bass_bloc.dart';

enum BassStatus { initial, success, failure }

class BassState extends Equatable {
  const BassState(
      {this.status = BassStatus.initial,
      this.basses = const <Bass>[],
      this.hasReachedMax = false,
      this.current = 0});

  final BassStatus status;
  final List<Bass> basses;
  final bool hasReachedMax;
  final int current;

  BassState copyWith(
      {BassStatus? status,
      List<Bass>? basses,
      bool? hasReachedMax,
      int? current}) {
    return BassState(
        status: status ?? this.status,
        basses: basses ?? this.basses,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        current: current ?? this.current);
  }

  @override
  String toString() {
    return '''BassState { status: $status, hasReachedMax: $hasReachedMax, basses: ${basses.length} }''';
  }

  @override
  List<Object> get props => [status, basses, hasReachedMax];
}
