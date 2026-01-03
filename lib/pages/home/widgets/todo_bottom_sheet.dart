import 'package:flutter/material.dart';

class TodoBottomSheet extends StatefulWidget {
  const TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  String? _validateTodoTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '무엇을 하고 싶으신가요?';
    }
    return null;
  }

  void _addTodo() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _focusNode.requestFocus();
      return;
    }

    Navigator.pop(context, _controller.text.trim());
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        top: 24,
        right: 24,
        bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Text(
            '오늘은 무엇을 하실건가요?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 100,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                autofocus: true,
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.done,
                validator: _validateTodoTitle,
                onFieldSubmitted: (_) => _addTodo(),
              ),
            ),
          ),
          FilledButton(
            onPressed: _addTodo,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(double.infinity, 48),
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }
}
