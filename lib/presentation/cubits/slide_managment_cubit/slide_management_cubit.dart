import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/services/firestore_service.dart';
import '../../../data/models/slide.dart';

part 'slide_management_state.dart';

/// `SlideManagementCubit` is a state management class that extends `Cubit`.
/// It handles the logic for loading, adding, updating, and deleting slides.
/// The Cubit emits different states to represent the current state of the slide management process.

class SlideManagementCubit extends Cubit<SlideManagementState> {
  final SlidesFirestoreService _slidesFirestoreService; // Service to interact with Firestore.
  StreamSubscription<List<Slide>>? _subscription; // Subscription to listen to slide changes.

  /// Constructor that initializes the Cubit with a `SlidesFirestoreService` instance.
  /// The Cubit starts in the `SlideManagementLoading` state and subscribes to slide updates.
  SlideManagementCubit(this._slidesFirestoreService)
      : super(SlideManagementLoading()) {
    _subscribeToSlides();
  }

  /// Private method to subscribe to slide changes from Firestore.
  /// Whenever there is an update in the slides collection, the Cubit will emit a new state.
  void _subscribeToSlides() {
    _subscription = _slidesFirestoreService.getSlides().listen(
          (slides) {
        // If slides are successfully loaded, emit the success state with the loaded slides.
        emit(SlidesLoadedSuccessfully(slides));
      },
      onError: (error) {
        // If there is an error while loading slides, emit a failure state.
        emit(SlideManagementFailure(error.toString()));
      },
    );
  }

  /// Method to add a new slide to Firestore.
  /// Before adding, it emits a `SlideManagementLoading` state to indicate the process.
  /// If the addition fails, it emits a `SlideManagementFailure` state with the error message.
  Future<void> addSlide(String question, String answer) async {
    try {
      emit(SlideManagementLoading());
      await _slidesFirestoreService.addSlide(question, answer);
    } catch (e) {
      emit(SlideManagementFailure(e.toString()));
    }
  }

  /// Method to update an existing slide in Firestore.
  /// It emits a `SlideManagementLoading` state during the update process.
  /// If the update fails, it emits a `SlideManagementFailure` state with the error message.
  Future<void> updateSlide(Slide slide) async {
    try {
      emit(SlideManagementLoading());
      await _slidesFirestoreService.updateSlide(slide);
    } catch (e) {
      emit(SlideManagementFailure(e.toString()));
    }
  }

  /// Method to delete a slide from Firestore using its ID.
  /// The process emits a `SlideManagementLoading` state.
  /// If the deletion fails, it emits a `SlideManagementFailure` state with the error message.
  Future<void> deleteSlide(String id) async {
    try {
      emit(SlideManagementLoading());
      await _slidesFirestoreService.deleteSlide(id);
    } catch (e) {
      emit(SlideManagementFailure(e.toString()));
    }
  }

  /// Override the `close` method to cancel the Firestore subscription
  /// when the Cubit is closed, preventing memory leaks.
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
