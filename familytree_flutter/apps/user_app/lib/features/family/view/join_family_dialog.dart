import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';

class JoinFamilyDialog extends StatefulWidget {
  const JoinFamilyDialog({super.key});

  @override
  State<JoinFamilyDialog> createState() => _JoinFamilyDialogState();
}

class _JoinFamilyDialogState extends State<JoinFamilyDialog> {
  final _tokenController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.joinFamily),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tokenController,
            decoration: InputDecoration(
              labelText: l10n.inviteToken,
              hintText: l10n.inviteTokenHint,
            ),
            autofocus: true,
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleJoin,
          child: _isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.join),
        ),
      ],
    );
  }

  Future<void> _handleJoin() async {
    final token = _tokenController.text.trim();
    if (token.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await familySignalsController.joinFamily(token);

      if (familySignalsController.error != null) {
        if (!mounted) return;
        setState(() {
          _error = AppLocalizations.of(
            context,
          )!.failedToJoin(familySignalsController.error!);
        });
      } else {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.successfullyJoinedFamily,
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = AppLocalizations.of(context)!.failedToJoin(e.toString());
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
