class Server {
  static Uri url(url) {
    Uri Server = Uri.parse("http://172.16.106.213/Baticraft/baticraft/fh_db/" + url);
    return Server;
  }

  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}
