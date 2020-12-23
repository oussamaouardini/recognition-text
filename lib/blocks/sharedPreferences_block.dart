import 'package:shared_preferences/shared_preferences.dart';



class AuthBloc {
  Future<bool> getSeenOnBoarding() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('seen');
  }
}
