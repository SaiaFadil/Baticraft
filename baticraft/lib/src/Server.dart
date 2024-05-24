class Server {



  // static String ROUTE = "http://172.16.103.228:8000/";
  static String ROUTE_HOSTING = "https://baticraft.tifnganjuk.com/";
  
  static Uri urlLaravel(url) {
    Uri Server = Uri.parse(ROUTE_HOSTING+"api/MobileApi/" + url); 
    return Server;
  }
  static String urlLaravelImageProduct(url) {
    String Server = ROUTE_HOSTING+"storage/product/" + url;
    return Server;
  }
  static String urlLaravelImageUser(url) {
    String Server = ROUTE_HOSTING+"storage/user/" + url;
    return Server;
  }
  static String urlLaravelImageInformation(url) {
    String Server = ROUTE_HOSTING+"storage/information/" + url;
    return Server;
  }
  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}


