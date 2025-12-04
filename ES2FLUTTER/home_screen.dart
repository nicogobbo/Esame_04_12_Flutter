import 'package:flutter/material.dart';
import 'review.dart';
import 'review_form.dart';

//schermata principale dell'app con le recensioni (commento mio prof)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Review> _reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Reviews")),
      body: _reviews.isEmpty
          ? const Center(child: Text("No reviews yet"))
          : ListView.builder(
              itemCount: _reviews.length,
              itemBuilder: (context, index) {
                final r = _reviews[index];
                return ListTile(
                  title: Text(r.title),
                  subtitle: Text("Rating: ${r.rating}/5\n${r.comment ?? ""}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editReview(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addReview,
      ),
    );
  }

  Future<void> _addReview() async {
    final result = await showDialog<Review>(
      context: context,
      builder: (_) => const ReviewFormDialog(),
    );

    if (result != null) {
      setState(() => _reviews.add(result));
    }
  }

  Future<void> _editReview(int index) async {
    final r = _reviews[index];

    final result = await showDialog<Review>(
      context: context,
      builder: (_) => ReviewFormDialog(review: r),
    );

    if (result != null) {
      setState(() => _reviews[index] = result);
    }
  }
}
