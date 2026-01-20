import 'package:dynamic_bounce/l10n/app_localizations.dart';
import 'package:dynamic_bounce/providers/player.dart';
import 'package:dynamic_bounce/widgets/buttons/back_to_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Player overlay.
class Player extends StatelessWidget {
  /// Creates a new player overlay.
  const Player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BackToHomeButton(),
        UserNameForm(),
      ],
    );
  }
}

/// User name form.
class UserNameForm extends ConsumerStatefulWidget {
  /// Creates a new user name form.
  const UserNameForm({
    super.key,
  });

  @override
  ConsumerState<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends ConsumerState<UserNameForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  var _isEditing = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Set player name as initial value.
      final player = await ref.read(playerProvider.notifier).fetchPlayer();
      _textEditingController.text = player.name;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isEditing = _focusNode.hasFocus;
    });
  }

  bool _isValidName(String? value) {
    return value != null && value.trim().isNotEmpty && value.length <= 8;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          controller: _textEditingController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            suffixIcon: _isEditing
                ? SaveButton(
                    formKey: _formKey,
                    textEditingController: _textEditingController,
                    focusNode: _focusNode,
                  )
                : EditButton(focusNode: _focusNode),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (!_isValidName(value)) {
              return l10n.playerNameValidationMessage;
            }
            return null;
          },
        ),
      ),
    );
  }
}

/// Edit button.
class EditButton extends StatelessWidget {
  /// Creates a new edit button.
  const EditButton({
    required this.focusNode,
    super.key,
  });

  /// Focus node.
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: focusNode.requestFocus,
    );
  }
}

/// Save button.
class SaveButton extends ConsumerWidget {
  /// Creates a new save button.
  const SaveButton({
    required this.formKey,
    required this.textEditingController,
    required this.focusNode,
    super.key,
  });

  /// Form key.
  final GlobalKey<FormState> formKey;

  /// Text editing controller.
  final TextEditingController textEditingController;

  /// Focus node.
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          ref
              .read(playerProvider.notifier)
              .updatePlayerName(textEditingController.text);
          focusNode.unfocus();
        }
      },
    );
  }
}
