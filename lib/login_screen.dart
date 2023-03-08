import 'package:clickcounter/admin_view.dart';
import 'package:clickcounter/student_view.dart';
import 'package:clickcounter/teacher_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _selectedValue = ValueNotifier<String>('admin');
  final userTypeController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userTypeController.text = _selectedValue.value;
  }

  @override
  void dispose() {
    _selectedValue.dispose();
    userTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  fillColor: Colors.blueGrey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                controller: userTypeController,
                decoration: const InputDecoration(
                  labelText: 'Category Type',
                ),
              ),
              DropdownButton<String>(
                value: _selectedValue.value,
                onChanged: (newValue) {
                  _selectedValue.value = newValue!;
                  userTypeController.text = newValue;
                },
                items: ['student', 'teacher', 'admin']
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('email', emailController.text.toString());
                    sp.setString('age', ageController.text.toString());
                    sp.setString(
                        'userType', userTypeController.text.toString());
                    // sp.setString('userType', 'student');
                    // sp.setString('userType', 'teacher');
                    // sp.setString('userType', 'admin');

                    sp.setBool('isLogin', true);

                    if (sp.getString('userType') == 'student') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudentView()));
                    } else if (sp.getString('userType') == 'teacher') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TeacherView()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminView()));
                    }
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
