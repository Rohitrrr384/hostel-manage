import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feedback = const [
      ('Breakfast', '4.4', 'Idli was fresh, chutney could be better.'),
      ('Lunch', '4.1', 'Good dal and roti. Add more salad options.'),
      ('Dinner', '3.8', 'Paneer was tasty but rice ran out early.'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Mess Feedback')),
      body: ResponsivePage(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Meal Feedback', subtitle: 'Recent student ratings and kitchen action items.', icon: Icons.rate_review, color: AppTheme.messColor),
          const SizedBox(height: 16),
          ...feedback.map((f) => Card(child: ListTile(leading: const Icon(Icons.star, color: AppTheme.warning), title: Text('${f.$1} • ${f.$2}/5'), subtitle: Text(f.$3), trailing: const Icon(Icons.chevron_right)))),
        ]),
      ),
    );
  }
}
