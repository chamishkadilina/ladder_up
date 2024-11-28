import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sing in
  signInWithGoogle() async {
    // begin interactice singn in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a neew credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, lets sing in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
