import 'package:flutter/material.dart';

import '../navigation_screen.dart';
import '../services/dataBase.dart';

class InitUserScreen extends StatefulWidget {
  const InitUserScreen(this.onToggleTheme, {super.key});
  final void Function() onToggleTheme;
  @override
  State<InitUserScreen> createState() => _InitUserScreenState();
}

class _InitUserScreenState extends State<InitUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _tagController = TextEditingController();
  final _ageController = TextEditingController();

  String _gender = 'Male';

  bool _loading = false;

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final userRepo = UserRepository();

    await userRepo.insertUser(
      User(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        tag: _tagController.text,
        age: int.parse(_ageController.text),
        gender: _gender,
        profilePicture: '',
      ),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => NavigationScreen(onToggleTheme: widget.onToggleTheme),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _tagController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _tagController,
                decoration: const InputDecoration(labelText: 'Tag'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator:
                    (v) => int.tryParse(v ?? '') == null ? 'Invalid age' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (v) => _gender = v!,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : _saveUser,
                child:
                    _loading
                        ? const CircularProgressIndicator()
                        : const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
