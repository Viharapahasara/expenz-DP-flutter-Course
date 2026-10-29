import 'dart:io';

import 'package:expenz/constants/colors.dart';
import 'package:expenz/page/profile_page/edit_profile_screen.dart';
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

  Future<void> navigateToEditProfile() async {
    final bool? updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialUsername: username,
          initialEmail: email,
          initialImagePath: profileImagePath,
        ),
      ),
    );

    if (updated == true && mounted) {
      await loadUserData();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
            Text('Name: ${username.trim().isEmpty ? 'Guest' : username}'),
            const SizedBox(height: 12),
            Text('Email: ${email.trim().isEmpty ? 'Not provided' : email}'),
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
              // 1. Close confirmation dialog
              Navigator.of(dialogContext).pop();

              // 2. Show non-dismissible loading indicator
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (_) => const PopScope(
                  canPop: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );

              try {
                // 3. Perform full local storage wipe
                await UserService.logout();
              } catch (error) {
                debugPrint('Logout failed: $error');
                if (mounted) {
                  Navigator.of(context, rootNavigator: true).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('An error occurred while logging out.'),
                    ),
                  );
                }
                return;
              }

              if (!mounted) return;

              // 4. Pop the loading dialog from root navigator
              Navigator.of(context, rootNavigator: true).pop();

              // 5. Clear navigation stack and redirect to onboarding/login
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                  builder: (_) => const OnboardingScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text(
              'Log out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayUsername =
        username.trim().isEmpty ? 'Guest' : username;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top * 2,
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "username",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kGrey,
                                  ),
                                ),
                                Text(
                                  displayUsername,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: kBlack,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: navigateToEditProfile,
                            icon: const Icon(
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
              const WidgetCard(
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
