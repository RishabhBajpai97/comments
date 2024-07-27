import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments/core/errors/exception.dart';
import 'package:comments/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel> signup({String name, String email, String password});
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  FirebaseAuth instance;
  FirebaseFirestore store;
  AuthRemoteDatasourceImpl(this.instance, this.store);
  @override
  Future<UserModel> signup(
      {String? name, String? email, String? password}) async {
    try {
      final userCredential = await instance.createUserWithEmailAndPassword(
          email: email!, password: password!);
      await instance.currentUser!.updateDisplayName(name);
      await store
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({"email": email, "name": name});
      final userData =
          await store.collection("users").doc(userCredential.user!.uid).get();

      UserModel userModel =
          UserModel.fromJSON(userData.data() as Map<String, dynamic>);
      return userModel.copyWith(uuid: userCredential.user!.uid);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCreds = await instance.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCreds.user != null) {
        final userData =
            await store.collection("users").doc(userCreds.user!.uid).get();
        UserModel userModel =
            UserModel.fromJSON(userData.data() as Map<String, dynamic>);
        return userModel.copyWith(uuid: userCreds.user!.uid);
      }
      throw ServerException("User not found");
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.code.toLowerCase().split("_").join(" "));
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> logout() async {
    await instance.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = instance.currentUser;
      if (user != null) {
        final userData = await _getUserFromFirebase(user.uid);
        return userData;
      } else {
        return null;
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  Future<UserModel> _getUserFromFirebase(String uid) async {
    final doc = await store.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null) {
      return UserModel(
        uuid: uid,
        email: data['email'],
        name: data['name'],
      );
    } else {
      throw Exception('User not found');
    }
  }
}
