class Server {
  
  static Uri url(url) {
    Uri Server = Uri.parse("http://172.16.103.63/Baticraft/baticraft/fh_db/" + url);
    return Server;
  }
 static String urlString(String url) {
    String Server = "http://172.16.103.63/Baticraft/baticraft/fh_db/" + url;
    return Server;
}
  static String urlImageDatabase(url) {
    String Server = "http://172.16.103.63/Baticraft/baticraft/fh_db/images/" + url;
    return Server;
  }
  static String urlProfilDatabase(url) {
    String Server = "http://172.16.103.63/Baticraft/baticraft/fh_db/images/profiles/" + url;
    return Server;
  }

  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}
