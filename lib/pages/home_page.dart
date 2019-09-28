import 'package:curso_flutter/data/save_local.dart';
import 'package:curso_flutter/pages/articles_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  final feedController = TextEditingController();

  List feeds = [];

  void initState() {

    final SaveLocal persistence = new SaveLocal(feedList: feeds);
    persistence.read().then((data) {
      setState(() {
        feeds = data;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SaveLocal persistence = new SaveLocal(feedList: feeds);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Artigos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: feeds.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(feeds[index]),
                      leading: Icon(Icons.rss_feed),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ArticlePage(feed: feeds[index]),
                        ));
                      },
                    );
                  },
                )
              ),
              TextFormField(
                keyboardType: TextInputType.url,
                controller: feedController,
                decoration: InputDecoration(
                  labelText: 'Link do RSS'
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo vazio!';
                  }
                },
              ),
              RaisedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    setState(() {
                      feeds.add(feedController.text);
                      feedController.text = '';
                      persistence.save(feeds);
                    });
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }
}