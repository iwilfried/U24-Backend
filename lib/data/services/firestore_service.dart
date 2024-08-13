import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/slide.dart';

class SlidesFirestoreService {
  final slideCollection = FirebaseFirestore.instance.collection('slides');

  Stream<List<Slide>> getSlides() {
    return slideCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Slide.fromFirestore(doc)).toList();
    });
  }

  Future<void> addSlide(String question, String answer) async {
    try {
      await slideCollection.add({'question': question, 'answer': answer});
    } catch (e) {
      throw Exception('Failed to add slide');
    }
  }

  Future<void> updateSlide(Slide slide) async {
    try {
      await slideCollection
          .doc(slide.id)
          .update({'question': slide.question, 'answer': slide.answer});
    } catch (e) {
      throw Exception('Failed to update slide');
    }
  }

  Future<void> deleteSlide(String id) async {
    try {
      await slideCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete slide');
    }
  }
}
