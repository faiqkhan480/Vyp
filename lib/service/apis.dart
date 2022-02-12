import 'package:vyp/utils/constants.dart';

class Api {
  static String middleWare = "/general";
  static String countries = Constants.baseURL+ middleWare + "/countries";
  static String districts = Constants.baseURL+ middleWare + "/districts/";
  static String counties = Constants.baseURL+ middleWare + "/counties/";
}