import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const DestinationScreen(email: ''),
        '/login': (context) => const DestinationLogin()
      },
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade700)
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DestinationLogin extends StatefulWidget {
  const DestinationLogin({super.key});
  
  @override
  State<DestinationLogin> createState() => _DestinationLogin();
}

class _DestinationLogin extends State<DestinationLogin> {

  late final TextEditingController loginController;
  late final TextEditingController passwordController;

  late String currentMail;
  late String currentPassword;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
    currentMail = '';
    currentPassword = '';
    
    loginController.addListener(() {
      setState(() => currentMail = loginController.text);
    });

    passwordController.addListener(() {
      setState(() => currentPassword = passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Builder(builder: (context) {
          return Column(
            children: [
              TextFormField(
                controller: loginController,
                decoration: const InputDecoration(
                  label: Text('e-mail : ')
                ),
                validator: (String? value) {
                  if (value?.isNotEmpty == false) {
                    return 'Ce champ est obligatoire';
                  }
                  if (value?.contains('@') == false ) {
                    return 'Veuillez saisir une adresse mail valide';
                  }
                  if (value?.compareTo("toto@gmail.com") != 0) {
                    return 'Adresse mail erronée';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  label: Text('password : ')
                ),
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Ce champ est obligatoire';
                  }
                  if (value?.compareTo("azerty") != 0) {
                    return 'Le mot de passe est faux';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: const Text('Se connecter'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationScreen(
                          email: loginController.text,
                      )),
                    );
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }

}

class DestinationScreen extends StatelessWidget {

  final String email;

  const DestinationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Où partons-nous ? $email'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/login'),
              icon: const Icon(Icons.account_box),
              color: Colors.pink.shade700
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Campagne',
                icon: Icon(Icons.house_siding),
              ),
              Tab(
                text: 'Sur l\'eau',
                icon: Icon(Icons.houseboat_outlined),
              ),
              Tab(
                text: 'Avec vue',
                icon: Icon(Icons.panorama),
              ),
              Tab(
                text: 'Bord de mer',
                icon: Icon(Icons.scuba_diving),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DestinationDetails(),
            Text('B'),
            Text('C'),
            Text('D'),
          ],
        ),
      ),
    );
  }
}

class DestinationDetails extends StatelessWidget {
  const DestinationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [DestinationPhoto(), DestinationInfos()],
    );
  }
}

class DestinationPhoto extends StatelessWidget {
  const DestinationPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/przntr.appspot.com/o/48bc7a49-b260-457a-b207-70a47f14e13c.png?alt=media&token=103ba2cf-5800-43d8-b9cf-21b4d0fae2a2',
            fit: BoxFit.cover,
            errorBuilder: (context, _, __) =>
                const Icon(Icons.warning, color: Colors.red),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ),
        const Positioned(left: 8, top: 8, child: MembersFavorite())
      ],
    );
  }
}

class MembersFavorite extends StatelessWidget {
  const MembersFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white70,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite, color: Colors.pink),
          /*SizedBox(width: 12),*/
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Coup de coeur Voyageurs'),
          )
        ],
      ),
    );
  }
}

class DestinationInfos extends StatelessWidget {
  const DestinationInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Paris, France'),
              Spacer(),
              Icon(Icons.star, color: Colors.orange),
              Text('4.78')
            ],
          ),
          Text('3-9 avril'),
          Text('120€ nuit'),
        ],
      ),
    );
  }
}