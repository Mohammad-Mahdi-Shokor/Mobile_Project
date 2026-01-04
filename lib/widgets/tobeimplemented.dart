import 'package:flutter/material.dart';

AlertDialog toBeImplemented(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    elevation: 10,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    backgroundColor: Theme.of(context).colorScheme.surface,
    title: Column(
      children: [
        Icon(
          Icons.construction_rounded,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text(
          'Coming Soon!',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(
        //   'This feature is under development',
        //   style: TextStyle(
        //     fontSize: 16,
        //     color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        //     height: 1.4,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
        // const SizedBox(height: 20),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Column(
        //     children: [
        //       Text(
        //         'Work in Progress',
        //         style: TextStyle(
        //           fontSize: 14,
        //           fontWeight: FontWeight.w600,
        //           color: Theme.of(context).colorScheme.primary,
        //         ),
        //       ),
        //       const SizedBox(height: 4),
        //       Text(
        //         'Stay tuned for updates',
        //         style: TextStyle(
        //           fontSize: 12,
        //           color: Theme.of(
        //             context,
        //           ).colorScheme.onSurface.withOpacity(0.6),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.code, size: 12, color: Colors.grey[500]),
            SizedBox(width: 4),
            Text(
              'Mostafa & Mohammad',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    ),
    actions: [
      Center(
        child: SizedBox(
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Got it!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ],
    actionsPadding: const EdgeInsets.only(bottom: 20, top: 8),
  );
}
