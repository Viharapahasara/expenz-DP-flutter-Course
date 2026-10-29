import 'dart:io';

import 'package:expenz/constants/colors.dart';
import 'package:expenz/page/profile_page/widget_card.dart';
import 'package:expenz/screen/onboard/onboarding_screen.dart';
import 'package:expenz/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String? profileImagePath;
  static const int _maxProfileImageBytes = 5 * 1024 * 1024;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final value = await UserService.getUserData();
      final String? imagePath = await UserService.getProfileImagePath();

      if (mounted) {
        setState(() {
          username = value['username'] ?? value['userName'] ?? 'Guest';
          email = value['email'] ?? '';
          profileImagePath = imagePath;
        });
      }
    } catch (error) {
      debugPrint('Error loading user data: $error');
    }
  }

  Future<void> showEditProfileDialog() async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: username);
    final TextEditingController emailController =
        TextEditingController(text: email);

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (String? value) => value == null || value.trim().isEmpty
                    ? 'Enter your name'
                    : null,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your email';
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                      .hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              await UserService.updateProfile(
                userName: nameController.text,
                email: emailController.text,
              );
              if (!mounted) return;
              setState(() {
                username = nameController.text.trim();
                email = emailController.text.trim();
              });
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameController.dispose();
    emailController.dispose();
  }

  Future<void> chooseProfileImage() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a photo'),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final int imageSize = await image.length();
      if (imageSize > _maxProfileImageBytes) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile image must be 5 MB or smaller.')),
        );
        return;
      }

      final String savedPath = await UserService.saveProfileImage(image);
      if (!mounted) return;
      setState(() => profileImagePath = savedPath);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not update profile image: $error')),
      );
    }
  }

  void showProfileDetails() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('My Profile Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $username'),
            const SizedBox(height: 12),
            Text('Email: ${email.isEmpty ? 'Not provided' : email}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'Are you sure you want to log out?\nAll your local data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Close the dialog
              Navigator.of(dialogContext).pop();

              // Show a loading indicator while wiping data
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              // Wipe all local data
              await UserService.logout();

              if (!mounted) return;

              // Remove the loading indicator and navigate to login
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (_) => const OnboardingScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Log out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              SizedBox(
                height: MediaQuery.of(context).padding.top*2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: chooseProfileImage,
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: kWhite,
                          shape: BoxShape.circle,
                          border: Border.all(color: kMainColor, width: 2.0),
                          image: profileImagePath == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(File(profileImagePath!)),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: profileImagePath == null
                            ? const Icon(Icons.add_a_photo_outlined, size: 26)
                            : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "username",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kGrey
                                ),
                              ),
                            //  SizedBox(width: 10),
                              Row(
                                children: [
                                 // SizedBox(width: 20),
                                  SizedBox(
                                    width: 210,
                                    child: Text(
                                      username,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: kBlack,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: showEditProfileDialog,
                            icon: Icon(
                              Icons.mode_edit_outline,
                              size: 35,
                              color: kGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
          
                    
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: kLightGrey,
                thickness: 2,
              ),
          
              WidgetCard(
                color: kMainColor,
                title: 'My Profile',
                icone: Icons.person,
                onTap: showProfileDetails,
              ),
              const Divider(
                color: kLightGrey,
                thickness: 2,
              ),
          
          
              WidgetCard(
                color: kMainColor,
                title: 'Settings',
                icone: Icons.settings,
              ),
              const Divider(
                color: kLightGrey,
                thickness: 2,
              ),
          
              WidgetCard(
                color: kRed,
                title: 'Logout',
                icone: Icons.logout,
                onTap: confirmLogout,
              ),
              const Divider(
                color: kLightGrey,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
