import 'package:vyv/utils/constants.dart';

class Api {
  static String middleWare = "/general";
  static String countries = Constants.baseURL + "/country/all";
  static String categories = Constants.baseURL + "/category/all";
  static String districts = Constants.baseURL + "/district/country/";
  static String counties = Constants.baseURL + "/county/country/";
  static String spot = Constants.baseURL + "/spot";
}