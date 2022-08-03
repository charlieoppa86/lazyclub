import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 인스턴스까지
final FirebaseAuth authInstance = FirebaseAuth.instance;
final User? user = authInstance.currentUser;
final uid = user!.uid;

// 유저 컬렉션까지
final usersRef = FirebaseFirestore.instance.collection('users');
