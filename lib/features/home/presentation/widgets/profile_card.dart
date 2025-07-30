import 'package:flutter/material.dart';
import '../../domain/entities/home_entity.dart';

class ProfileCard extends StatelessWidget {
  final UserProfileEntity userProfile;
  final double balance;

  const ProfileCard({
    super.key,
    required this.userProfile,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Foto de perfil circular
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        // Nombre del usuario
        Text(
          userProfile.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Balance disponible
        Text(
          '\$${balance.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Available balance',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
