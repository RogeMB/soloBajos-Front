import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:solo_bajos/models/bass.dart';
import 'package:solo_bajos/repositories/bass_repo.dart';
import 'package:stream_transform/stream_transform.dart';
import 'dart:async';
part 'bass_event.dart';
part 'bass_state.dart';

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class BassBloc extends Bloc<BassEvent, BassState> {
  BassBloc(/*{required this.httpClient}*/) : super(const BassState()) {
    //PostBloc({required this.repo}) : super(const PostState()) {
    repo = GetIt.I.get<BassRepository>();
    on<BassFetched>(
      _onBassFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  late BassRepository repo;

  Future<void> _onBassFetched(
    BassFetched event,
    Emitter<BassState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == BassStatus.initial) {
        //final posts = await _fetchPosts();
        final basses = await repo.findAllBasses();
        return emit(
          state.copyWith(
              status: BassStatus.success,
              basses: basses.content,
              hasReachedMax: basses.last,
              current: basses.currentPage),
        );
      }
      //final posts = await _fetchPosts(state.posts.length);
      final basses = await repo.findAllBasses(state.current + 1);
      emit(
        state.copyWith(
            status: BassStatus.success,
            basses: List.of(state.basses)..addAll(basses.content!),
            hasReachedMax: basses.last,
            current: basses.currentPage),
      );
    } catch (_) {
      emit(state.copyWith(status: BassStatus.failure));
    }
  }
}
