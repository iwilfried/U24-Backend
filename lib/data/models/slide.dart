import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Slide {
  String id;
  String question;
  String answer;

  Slide({required this.id, required this.question, required this.answer});

  factory Slide.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Slide(
      id: doc.id,
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
