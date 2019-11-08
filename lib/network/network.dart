class Network {

  static const String SERVER_URL = "https://cars-2f419.firebaseio.com";
  static const String CARS_LIST = "/cars";
  static const String CARS_ID = "/cars/";
  static const String JSON_TYPE = ".json";


  static const String CARS = SERVER_URL + CARS_LIST + JSON_TYPE;


  String getCarByIdUrl(int id) {
    return SERVER_URL + CARS_ID + id.toString() + JSON_TYPE;
  }
}