import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/slide.dart';
import '../data/services/firestore_service.dart';
import 'cubits/slide_managment_cubit/slide_management_cubit.dart';

/// `SlidesShowDialogs` is a utility class that contains static methods
/// for displaying dialogs that allow users to add, edit, or delete slides.
/// These dialogs interact with the `SlideManagementCubit` to perform CRUD operations.
class SlidesShowDialogs {

  /// Private constructor to prevent instantiation of this utility class.
  SlidesShowDialogs._();

  /// Displays a dialog that allows the user to edit an existing slide.
  ///
  /// This dialog contains two text fields: one for the question and one for the answer.
  /// The dialog uses a `SlideManagementCubit` to update the slide in the database.
  static void editSlide(BuildContext context, Slide slide) {
    TextEditingController questionController =
    TextEditingController(text: slide.question);
    TextEditingController answerController =
    TextEditingController(text: slide.answer);

    /// Shows the dialog on the screen.
    showDialog(
      context: context,
      builder: (context) {

        /// Provides a new instance of `SlideManagementCubit` to the dialog's widget tree.
        return BlocProvider(
          create: (context) =>
              SlideManagementCubit(context.read<SlidesFirestoreService>()),

          /// Uses a `Builder` to gain access to the updated context.
          child: Builder(
            builder: (context) => AlertDialog(

              /// Title of the dialog.
              title: const Text('Edit Slide'),

              /// The content of the dialog, which includes two text fields.
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: questionController,
                    decoration: const InputDecoration(labelText: 'Question'),
                  ),
                  TextField(
                    controller: answerController,
                    decoration: const InputDecoration(labelText: 'Answer'),
                  ),
                ],
              ),

              /// The actions at the bottom of the dialog.
              actions: [

                /// A button to cancel and close the dialog.
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                /// A button to save the updated slide.
                ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () async {

                    /// Creates an updated slide with the new question and answer.
                    final updatedSlide = Slide(
                        id: slide.id,
                        question: questionController.text,
                        answer: answerController.text);

                    /// Calls the `updateSlide` method of `SlideManagementCubit` to save the changes.
                    context
                        .read<SlideManagementCubit>()
                        .updateSlide(updatedSlide);

                    /// Closes the dialog.
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a dialog that allows the user to add a new slide.
  ///
  /// This dialog contains two text fields: one for the question and one for the answer.
  /// The dialog uses a `SlideManagementCubit` to add the slide to the database.
  static void addSlide(BuildContext context) {
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController = TextEditingController();

    /// Shows the dialog on the screen.
    showDialog(
      context: context,
      builder: (context) {

        /// Provides a new instance of `SlideManagementCubit` to the dialog's widget tree.
        return BlocProvider(
          create: (context) =>
              SlideManagementCubit(context.read<SlidesFirestoreService>()),

          /// Uses a `Builder` to gain access to the updated context.
          child: Builder(
            builder: (context) => AlertDialog(

              /// Title of the dialog.
              title: const Text('Add Slide'),

              /// The content of the dialog, which includes two text fields.
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: questionController,
                    decoration: const InputDecoration(labelText: 'Question'),
                  ),
                  TextField(
                    controller: answerController,
                    decoration: const InputDecoration(labelText: 'Answer'),
                  ),
                ],
              ),

              /// The actions at the bottom of the dialog.
              actions: [

                /// A button to cancel and close the dialog.
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                /// A button to add the new slide.
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () async {

                    /// Calls the `addSlide` method of `SlideManagementCubit` to save the new slide.
                    await context.read<SlideManagementCubit>().addSlide(
                      questionController.text,
                      answerController.text,
                    );

                    /// If the context is still mounted, close the dialog.
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a dialog to confirm the deletion of a slide.
  ///
  /// This dialog asks the user if they are sure about deleting the slide.
  /// The dialog uses a `SlideManagementCubit` to delete the slide from the database.
  static void deleteSlide(BuildContext context, String id) async {

    /// Shows the dialog on the screen.
    showDialog(
      context: context,
      builder: (context) {

        /// Provides a new instance of `SlideManagementCubit` to the dialog's widget tree.
        return BlocProvider(
          create: (context) => SlideManagementCubit(
            context.read<SlidesFirestoreService>(),
          ),

          /// Uses a `Builder` to gain access to the updated context.
          child: Builder(
            builder: (context) => AlertDialog(

              /// Title of the dialog.
              title: const Text('Confirm Deletion'),

              /// The content of the dialog, which asks for confirmation.
              content:
              const Text('Are you sure you want to delete this slide?'),

              /// The actions at the bottom of the dialog.
              actions: [

                /// A button to cancel and close the dialog.
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                /// A button to confirm the deletion of the slide.
                ElevatedButton(
                  child: const Text('Delete'),
                  onPressed: () async {

                    /// Calls the `deleteSlide` method of `SlideManagementCubit` to delete the slide.
                    await context.read<SlideManagementCubit>().deleteSlide(id);

                    /// If the context is still mounted, close the dialog.
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
