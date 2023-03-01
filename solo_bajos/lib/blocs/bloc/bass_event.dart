part of 'bass_bloc.dart';

abstract class BassEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BassFetched extends BassEvent {}
