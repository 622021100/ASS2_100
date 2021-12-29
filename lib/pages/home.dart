import 'package:flutter/material.dart';
import 'package:textformfield100/models/food.dart';
import 'package:textformfield100/models/subject.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String? foodValue;

  late List<Food> foods;
  late List<Subject> subjects;

  List<ListItem> dropdownItem = ListItem.getListItem();
  late List<DropdownMenuItem<ListItem>> dropdownMenuItem;
  late ListItem _selectedItem;

  List selectedSubject = [];

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subjects = Subject.getSubject();
    dropdownMenuItem = createDropdownMenu(dropdownItem);
    _selectedItem = dropdownMenuItem[0].value!;
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenu(
      List<ListItem> dropdownItem) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in dropdownItem) {
      items.add(DropdownMenuItem(child: Text(item.name!), value: item));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    username(),
                    password(),
                    Column(
                      children: createFoodRadio(),
                    ),
                    Text('Item Selected; $foodValue'),
                    const SizedBox(height: 14),
                    Column(
                      children: createSubjectCheckbox(),
                    ),
                    const SizedBox(height: 14),
                    DropdownButton(
                      value: _selectedItem,
                      items: dropdownMenuItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value as ListItem;
                        });
                      },
                    ),
                    Text('Item selected: ' +
                        _selectedItem.value!.toString() +
                        ' ' +
                        _selectedItem.name!),
                    submitButton(),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // ignore: avoid_print
          print(_usernamecontroller.text);
          // ignore: avoid_print
          print(_passwordcontroller.text);
        }
      },
      child: const Text('Submit'),
    );
  }

  Padding password() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextFormField(
        obscureText: true,
        controller: _passwordcontroller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please! Enter your Password ';
          }
          return null;
        },
        decoration: const InputDecoration(
            label: Text('Password'),
            prefixIcon: Icon(Icons.lock),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 2.0,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ))),
      ),
    );
  }

  TextFormField username() {
    return TextFormField(
      controller: _usernamecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please! Enter your Username';
        }
        return null;
      },
      decoration: const InputDecoration(
          label: Text('Username'),
          prefixIcon: Icon(Icons.person),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: Colors.redAccent,
                width: 2.0,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide(
              color: Colors.lightBlue,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ))),
    );
  }

  List<Widget> createFoodRadio() {
    List<Widget> listRadioFood = [];
    for (var food in foods) {
      listRadioFood.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: RadioListTile<dynamic>(
            title: Text(food.thName!),
            subtitle: Text(food.enName!),
            //ราคา ข้างขวา
            secondary: Text(food.price!.toString() + '฿'),
            // tileColor: Colors.blueAccent,
            value: food.foodValue,
            groupValue: foodValue,
            onChanged: (value) {
              setState(() {
                foodValue = value.toString();
              });
            },
          ),
        ),
      );
    }
    return listRadioFood;
  }

  List<Widget> createSubjectCheckbox() {
    List<Widget> listCheckboxSubject = [];

    for (var subject in subjects) {
      listCheckboxSubject.add(
        CheckboxListTile(
          title: Text(subject.subName!),
          subtitle: Text('credit: ${subject.credit}'),
          value: subject.checked,
          onChanged: (value) {
            setState(() {
              subject.checked = value!;
            });
            if (value!) {
              selectedSubject.add(subject.subName!);
            } else {
              selectedSubject.remove(subject.subName!);
            }
            print(selectedSubject);
          },
        ),
      );
    }
    return listCheckboxSubject;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);
  static List<ListItem> getListItem() {
    return [
      ListItem(1, 'Item 1'),
      ListItem(2, 'Item 2'),
      ListItem(3, 'Item 3'),
      ListItem(4, 'Item 4'),
    ];
  }
}
