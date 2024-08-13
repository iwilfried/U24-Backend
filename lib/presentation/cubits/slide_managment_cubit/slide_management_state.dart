part of 'slide_management_cubit.dart';

/// `SlideManagementState` is an abstract base class representing all possible states
/// that the `SlideManagementCubit` can emit. Each specific state extends this base class.
@immutable
abstract class SlideManagementState {}

/// Represents the state when the slide management process is in a loading state.
/// This state is typically emitted when the application is performing operations such as
/// fetching, adding, updating, or deleting slides.
class SlideManagementLoading extends SlideManagementState {}

/// Represents the state when a slide has been successfully deleted.
/// This state is emitted after the `deleteSlide` operation completes successfully.
class SlideDeletedSuccessfully extends SlideManagementState {}

/// Represents the state when a slide has been successfully added.
/// This state is emitted after the `addSlide` operation completes successfully.
class SlideAddedSuccessfully extends SlideManagementState {}

/// Represents the state when a slide has been successfully updated.
/// This state is emitted after the `updateSlide` operation completes successfully.
class SlideUpdatedSuccessfully extends SlideManagementState {}

/// Represents the state when slides have been successfully loaded from Firestore.
/// This state contains a list of `Slide` objects that were retrieved.
class SlidesLoadedSuccessfully extends SlideManagementState {
  final List<Slide> slides; // The list of slides retrieved from Firestore.

  /// Constructor that initializes the `SlidesLoadedSuccessfully` state with the loaded slides.
  SlidesLoadedSuccessfully(this.slides);
}

/// Represents the state when a slide management operation fails.
/// This state contains an error message explaining why the operation failed.
class SlideManagementFailure extends SlideManagementState {
  final String error; // The error message explaining the failure.

  /// Constructor that initializes the `SlideManagementFailure` state with the error message.
  SlideManagementFailure(this.error);
}
