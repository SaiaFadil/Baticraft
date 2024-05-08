class Server {
  static String ROUTE = "http://172.16.103.137:8000/";


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


