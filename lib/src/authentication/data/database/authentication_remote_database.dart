import 'package:evangelism_admin/core/leader/domain/entities/leader.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDatabase {
  Future<Leader> login(String email, String password);
  Future<Leader> logout();
}

class AuthenticationRemoteDatabaseImpl implements AuthenticationRemoteDatabase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Leader> login(String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    Leader leader = Leader(
      name: userCredential.user!.displayName!,
      email: userCredential.user!.email!,
      id: userCredential.user!.uid,
    );

    return leader;
  }

  @override
  Future<Leader> logout() async {
    await _firebaseAuth.signOut();
    return Leader.initial();
  }
}
