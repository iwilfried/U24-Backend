import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/firestore_service.dart';
import '../slides_show_dialogs.dart';
import '../cubits/slide_managment_cubit/slide_management_cubit.dart';

/// This is the main screen where an admin can manage slides (add, edit, delete).
/// It's a stateful widget because it needs to manage dynamic content.

class AdminSlideScreen extends StatefulWidget {
  const AdminSlideScreen({super.key});

  @override
  createState() => _AdminSlideScreenState();
}

class _AdminSlideScreenState extends State<AdminSlideScreen> {
  /// The build method is where the UI of the screen is built.
  /// It returns a Scaffold, which is a basic layout structure in Flutter.
  @override
  Widget build(BuildContext context) {
    /// RepositoryProvider is used here to provide the SlideManagementCubit
    /// to the widget tree. This allows any child widget to access the Cubit.
    /// The SlideManagementCubit is responsible for managing the state of the slides.
    return RepositoryProvider(
      create: (context) => SlideManagementCubit(
        context.read<SlidesFirestoreService>(),
      ),

      /// Builder is used to create a new context that has access to the SlideManagementCubit.
      /// This is important for using BlocBuilder below.
      child: Builder(builder: (context) {
        /// Scaffold is the main structure for the UI.
        /// It provides an AppBar, a body, and a floating action button.
        return Scaffold(
          /// The AppBar at the top of the screen with the title 'Slide Management'.
          appBar: AppBar(
            title: const Text('Slide Management'),
          ),

          /// BlocBuilder is a widget that reacts to changes in the Cubit state.
          /// It listens to the SlideManagementCubit and rebuilds the UI when the state changes.
          body: BlocBuilder<SlideManagementCubit, SlideManagementState>(
            builder: (context, state) {
              /// When the slides are successfully loaded, display them in a DataTable.
              if (state is SlidesLoadedSuccessfully) {
                return Align(
                  alignment: Alignment.topCenter,

                  /// DataTable is a widget that displays data in a table format.
                  /// It consists of columns (headers) and rows (data).
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Question')),
                      DataColumn(label: Text('Answer')),
                      DataColumn(label: Text('Actions')),
                    ],

                    /// Here, each slide is mapped to a DataRow.
                    /// Each row contains the slide's question, answer, and action buttons (edit/delete).
                    rows: state.slides.map((slide) {
                      return DataRow(cells: [
                        DataCell(Text(slide.question)),
                        DataCell(Text(slide.answer)),
                        DataCell(Row(
                          children: [
                            /// The edit button triggers a dialog to edit the slide.
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  SlidesShowDialogs.editSlide(context, slide),
                            ),

                            /// The delete button triggers a dialog to confirm deletion of the slide.
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => SlidesShowDialogs.deleteSlide(
                                  context, slide.id),
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                );
              }

              /// If there are no slides loaded, show a message instead.
              return const Text("No slides data to show");
            },
          ),

          /// FloatingActionButton is a button floating above the content, used to add new slides.
          floatingActionButton: FloatingActionButton(
            onPressed: () => SlidesShowDialogs.addSlide(context),
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
