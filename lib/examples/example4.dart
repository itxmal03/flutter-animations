import 'package:flutter/material.dart';

class Example4 extends StatefulWidget {
  const Example4({super.key});

  @override
  State<Example4> createState() => _Example4State();
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: "Ali", age: 20, emoji: "🙋🏻‍♂️"),
  Person(name: "Ahmad", age: 18, emoji: "🧑🏻"),
  Person(name: "Ayesha", age: 20, emoji: "🧑🏻‍🎓"),
  Person(name: "Fatima", age: 22, emoji: "👩🏻‍🦰"),
  Person(name: "Zain", age: 19, emoji: "👨🏻‍🦱"),
  Person(name: "Hassan", age: 24, emoji: "👨🏻‍🦳"),
  Person(name: "Maryam", age: 21, emoji: "👱🏻‍♀️"),
  Person(name: "Usman", age: 23, emoji: "👨🏻‍🦰"),
  Person(name: "Noor", age: 18, emoji: "👩🏻"),
  Person(name: "Bilal", age: 26, emoji: "👨🏻"),
  Person(name: "Sara", age: 19, emoji: "🧕🏻"),
  Person(name: "Hamza", age: 27, emoji: "🧔🏻"),
  Person(name: "Hina", age: 25, emoji: "👩🏻‍🦱"),
  Person(name: "Omar", age: 30, emoji: "👨🏻‍🦲"),
  Person(name: "Zoya", age: 17, emoji: "👧🏻"),
  Person(name: "Ibrahim", age: 28, emoji: "🧔🏻‍♂️"),
  Person(name: "Amna", age: 24, emoji: "👩🏻‍🦳"),
  Person(name: "Yusuf", age: 16, emoji: "👦🏻"),
  Person(name: "Eman", age: 20, emoji: "👩🏻"),
  Person(name: "Khalid", age: 35, emoji: "👴🏻"),
];

class _Example4State extends State<Example4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'People',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.withValues(alpha: 0.3),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(person: person),
                ),
              );
            },
            title: Text(
              person.name,
              style: TextStyle(fontSize: 18, fontWeight: .bold),
            ),
            subtitle: Text(
              '${person.age} years old',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            leading: Hero(
              tag: person.name,
              child: Text(person.emoji, style: TextStyle(fontSize: 40)),
            ),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Person person;
  const DetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder:
              (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
                        ),
                        child: toHeroContext.widget,
                      ),
                    );
                  case HeroFlightDirection.pop:
                    return Material(
                      color: Colors.transparent,
                      child: toHeroContext.widget,
                    );
                }
              },
          tag: person.name,
          child: Text(person.emoji, style: TextStyle(fontSize: 40)),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.withValues(alpha: 0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              Text(
                'Name: ${person.name}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text(
                'Age: ${person.age} years old',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
