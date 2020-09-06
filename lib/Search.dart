import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:url_launcher/url_launcher.dart';
class Search extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Search> {
  bool isLoading = false;
  String stri;
  String element = "Make your search...";
  _launchURL()async {
    String url = "https://www.google.com/search?q=$stri+company+country+of+origin";
    if(await canLaunch(url))
      await launch(url);
    else
      print('Cannot launch url');
  }
  Future fetchData(String str) async {
    final webScraper = WebScraper('https://www.wikipedia.org');
    print("coming");
    if (await webScraper.loadWebPage('/wiki/$str')) {
      isLoading = false;

      try {
        var elements = webScraper.getElement('td.adr', []);
        print(elements);
        element = elements[0]['title'];
      } on RangeError {
        try {
          var elements1 = webScraper.getElement('td.label', []);
          element = elements1[0]['title'];
        } on RangeError {
          element = "Not In our database :(";
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onSubmitted: (String str) {
                      setState(() {
                        stri = str;
                        isLoading = true;
                      });

                      fetchData(str);
                      print('Submitted');
                    },
                  ),
                  SizedBox(height: 200),
                  isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Center(
                      child: Text(
                        element,
                        style: TextStyle(fontSize: 25),
                      )),
                  element == "Not In our database :("
                      ? RaisedButton(
                    onPressed: _launchURL,
                    color: Colors.cyan,
                    child: Text('Search on web?',style: TextStyle(color: Colors.white),),
                  )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
