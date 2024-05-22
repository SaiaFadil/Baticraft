class Server {


  static String ROUTE = "http://192.168.1.40:8000/";
  static String ROUTE_HOSTING = "http://https://baticraft.tifnganjuk.com/";
  
  static Uri urlLaravel(url) {
    Uri Server = Uri.parse(ROUTE+"api/MobileApi/" + url); 
    return Server;
  }
  static String urlLaravelImageProduct(url) {
    String Server = ROUTE+"storage/product/" + url;
    return Server;
  }
  static String urlLaravelImageUser(url) {
    String Server = ROUTE+"storage/user/" + url;
    return Server;
  }
  static String urlLaravelImageInformation(url) {
    String Server = ROUTE+"storage/information/" + url;
    return Server;
  }
  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}


