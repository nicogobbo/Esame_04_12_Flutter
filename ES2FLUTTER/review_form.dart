import "package:flutter/material.dart";
import "package:reactive_forms/reactive_forms.dart";

import "review.dart";

class ReviewFormDialog extends StatefulWidget {
  const ReviewFormDialog({super.key, this.review});
  final Review? review;

  @override
  State<ReviewFormDialog> createState() => _ReviewFormDialogState();
}

class _ReviewFormDialogState extends State<ReviewFormDialog> {
  late final FormGroup form;

  @override
  void initState() {
    super.initState();

    form = FormGroup({
      "title": FormControl<String>(
        value: widget.review?.title ?? "",
        validators: [Validators.required],
      ),
      "comment": FormControl<String>(
        value: widget.review?.comment ?? "",
      ),
      "rating": FormControl<int>(
        value: widget.review?.rating ?? 3,
        validators: [
          Validators.min(1),
          Validators.max(5),
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveTextField<String>(
                formControlName: "title",
                decoration: const InputDecoration(labelText: "Title"),
              ),
              ReactiveTextField<String>(
                formControlName: "comment",
                decoration: const InputDecoration(labelText: "Comment"),
              ),
              const SizedBox(height: 10),
              const Text("Rating (1–5)"),
              ReactiveSlider(
                formControlName: "rating",
                min: 1,
                max: 5,
                divisions: 4,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!form.valid) return;

    Navigator.pop(
      context,
      Review(
        title: form.control("title").value as String,
        comment: form.control("comment").value as String?,
        rating: form.control("rating").value as int,
      ),
    );
  }
}
