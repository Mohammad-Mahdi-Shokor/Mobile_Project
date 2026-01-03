// screens/user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_project/navigation_screen.dart';
import 'dart:io';
import '../models/data.dart';
import '../models/user.dart';
import '../services/user_preferences_services.dart';

class UserProfileScreen extends StatefulWidget {
  final bool isEditing;
  final void Function() onToggleTheme;
  const UserProfileScreen({
    super.key,
    this.isEditing = false,
    this.onToggleTheme = _defaultToggleTheme,
  });

  static void _defaultToggleTheme() {}

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserPreferencesService _userService = UserPreferencesService.instance;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Variables
  String _selectedGender = 'Male';
  String _profileImage = '';
  bool _isLoading = false;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // Available tags
  final List<String> _availableTags = [
    'Student',
    'Software Engineer',
    'Teacher',
    'Developer',
    'Designer',
    'Researcher',
    'Entrepreneur',
    'Freelancer',
    'Manager',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (widget.isEditing) {
      setState(() => _isLoading = true);

      final user = await _userService.getUser();
      if (user != null) {
        _usernameController.text = user.username;
        _firstNameController.text = user.FirstName;
        _tagController.text = user.tag;
        _ageController.text = user.age.toString();
        _selectedGender = user.Gender;
        _profileImage = user.profilePicture;
      }

      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _profileImage = pickedFile.path;
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _profileImage = pickedFile.path;
      });
    }
  }

  Future<void> _saveUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = User(
        username: _usernameController.text.trim(),
        FirstName: _firstNameController.text.trim(),
        tag: _tagController.text.trim(),
        age: int.tryParse(_ageController.text) ?? 0,
        Gender: _selectedGender,
        profilePicture:
            _profileImage.isEmpty
                ? 'https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg'
                : _profileImage,
        achievementsScores: List.filled(13, 0.0), // Default scores
        registeredCourses: [],
        registedCoursesIndexes: [],
      );

      final saved = await _userService.saveUser(user);

      if (saved) {
        // Mark first launch as completed
        await _userService.setFirstLaunchCompleted();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.isEditing
                  ? 'Profile updated successfully!'
                  : 'Welcome ${user.username}!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home screen
        if (!widget.isEditing) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return NavigationScreen(onToggleTheme: widget.onToggleTheme);
              },
            ),
          );
        } else {
          Navigator.pop(context, true); // Return success
        }
      } else {
        throw Exception('Failed to save user data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Edit Profile' : 'Complete Your Profile',
          style: GoogleFonts.poppins(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      GestureDetector(
                        onTap: () {
                          _showImageSourceDialog();
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child:
                                    _profileImage.isNotEmpty
                                        ? _profileImage.startsWith('http')
                                            ? Image.network(
                                              _profileImage,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return _buildDefaultAvatar();
                                              },
                                            )
                                            : Image.file(
                                              File(_profileImage),
                                              fit: BoxFit.cover,
                                            )
                                        : _buildDefaultAvatar(),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tap to change photo',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Username
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          if (value.length < 3) {
                            return 'Username must be at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // First Name
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: const Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Age
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: const Icon(Icons.cake),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your age';
                          }
                          final age = int.tryParse(value);
                          if (age == null || age < 1 || age > 120) {
                            return 'Please enter a valid age (1-120)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Gender
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: const Icon(Icons.people),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items:
                            ['Male', 'Female', 'Brain illed']
                                .map(
                                  (gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select gender';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Tag/Profession
                      DropdownButtonFormField<String>(
                        value:
                            _tagController.text.isEmpty
                                ? null
                                : _tagController.text,
                        decoration: InputDecoration(
                          labelText: 'Profession/Tag',
                          prefixIcon: const Icon(Icons.work),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        hint: const Text('Select your profession'),
                        items:
                            _availableTags
                                .map(
                                  (tag) => DropdownMenuItem(
                                    value: tag,
                                    child: Text(tag),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _tagController.text = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your profession';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isLoading
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text(
                                    widget.isEditing
                                        ? 'Update Profile'
                                        : 'Get Started',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),

                      // Delete account button (only in edit mode)
                      if (widget.isEditing) ...[
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: _showDeleteConfirmation,
                          child: Text(
                            'Delete Account',
                            style: GoogleFonts.poppins(color: Colors.red),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.person, size: 60, color: Colors.grey),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Choose Image Source'),
            content: const Text('Select how you want to add a profile picture'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage();
                },
                child: const Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
                child: const Text('Camera'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _deleteAccount();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => _isLoading = true);

    final deleted = await _userService.deleteUser();

    setState(() => _isLoading = false);

    if (deleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/welcome');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete account'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
