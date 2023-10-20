import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _sexe;
  bool? _football = false;
  bool? _music = false;
  bool? _lecture = false;
  String _name = "Mathias KINNINKPO";
  final _formKey = new GlobalKey<FormState>();
  bool _loading = false;
  bool _displayInfo = false;


  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text("Êtes-vous sûr de vouloir soumettre le formulaire ?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Annuler'),
                  child: const Text("Annuler")
              ),
              TextButton(
                  onPressed: ()  {
                    Navigator.pop(context, 'OK');
                    setState(() {
                      _loading = true;
                    });
                    Future.delayed(const Duration(seconds: 6), (){
                      setState(() {
                        _loading = false;
                        _name = _nameController.text;
                        _displayInfo = true;
                      });
                    });
                  },
                  child: const Text("OK")
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Mathias app", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.add_alert, color: Colors.white,)),
          IconButton(onPressed: null, icon: Icon(Icons.search, color: Colors.white,))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
                child: Text(_name, style: TextStyle(color: Colors.white),)
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.green,),
              title: Text("Message"),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.green,),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.green,),
              title: Text("Settings"),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Inscription"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Information"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed:  () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bouton flotant cliqué !"),)
          );
        },
      ),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Information de l'utilisateur", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20.5), textAlign: TextAlign.center,),
            SizedBox(height: 15.0,),
            Center(
              child: Image.asset("assets/image/download.png", scale: 1.5,),
            ),
            SizedBox(height: 20.0,),
            Form(
              key: _formKey,
                child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Nom et Prénom"),
                    icon: Icon(Icons.person),
                    hintText: "Entrez votre nom & prénom",
                  ),
                  validator: (String? value) {
                    return value == "" || value == null ? "Ce champ est obligatoire" : null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text("Mot de passe"),
                    icon: Icon(Icons.lock),
                    suffix: Icon(Icons.visibility),
                    hintText: "Entrez votre mot de passe",

                  ),
                  validator: (String? value) {
                    return value == "" || value == null ? "le mot de passe est obligatoire" : null;
                  },
                ),
                DropdownButtonFormField(
                  style: TextStyle(color: Colors.white),
                    decoration:  new InputDecoration(
                      icon: Icon(Icons.transgender),
                      hintText: "Quel est votre sexe",
                      labelText: "Sexe *"
                    ),
                    value: _sexe,
                    validator: (String? value){
                      return value == null ? "Ce champs est obligatoire" : null;
                    },
                    items: <String>['Masculin', 'Féminin', 'Autre']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),)
                      );
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        _sexe = value;
                      });
                    }

                ),
                SizedBox(height: 50.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Quels sont vos passe temps ?", style: TextStyle(fontSize: 16.0),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: _football,
                              checkColor: Colors.white,
                              onChanged: (bool? val){
                                setState(() {
                                  _football = val;
                                });
                              }
                          ),
                          Text("Football", style: TextStyle(
                            color: Colors.black,
                          ),),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: _lecture,
                              checkColor: Colors.white,
                              onChanged: (bool? val){
                                setState(() {
                                  _lecture = val;
                                });
                              }
                          ),
                          Text("Lecture", style: TextStyle(
                            color: Colors.black,
                          ),),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: _music,
                              checkColor: Colors.white,
                              onChanged: (bool? val){
                                setState(() {
                                  _music = val;
                                });
                              }
                          ),
                          Text("Music", style: TextStyle(
                            color: Colors.black,
                          ),),

                        ],
                      )
                    ],
                  ),
                )

                
              ],
            ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _displayDialog(context);
                    }
                  },
                  child: Text("Valider",
                    style: TextStyle(color: Colors.green), ),
                ),
                SizedBox(width: 10.0,),
                _loading ? CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 5,) : SizedBox()
              ],
            ),
            _displayInfo ? Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: "Je m'appelle  ", style: TextStyle(color: Colors.black)),
                          TextSpan(text: _name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),

                        ]
                      ),
                    ),
                    subtitle: Text("Voici mes passions"),

                  ),
                  /*ListTile(
                    title: ,
                  )*/

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {

                          },
                          child: const Text("AJOUTER")
                      ),
                      const SizedBox(width: 8,)

                    ],
                  )
                ],
              ),
            ) : SizedBox()
          ],
        ),
      ),

    );
  }
}





