import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TempoFirebaseUser {
  TempoFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

TempoFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TempoFirebaseUser> tempoFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TempoFirebaseUser>((user) => currentUser = TempoFirebaseUser(user));
