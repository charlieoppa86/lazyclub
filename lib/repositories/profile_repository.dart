import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lazyclub/constants/db_constants.dart';
import 'package:lazyclub/models/custom_error_model.dart';
import 'package:lazyclub/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final User currentUser = User.fromDoc(userDoc);
        return currentUser;
      }
      throw '유저가 없습니다';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: '에러 발생',
        message: e.toString(),
        plugin: '서버 에러',
      );
    }
  }
}
