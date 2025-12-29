import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final ButtonType type;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.type = ButtonType.primary,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final Widget buttonChild = isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == ButtonType.primary
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppConstants.iconMd),
                const SizedBox(width: AppConstants.spacingSm),
              ],
              Flexible(
                child: Text(
                  text,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: type == ButtonType.primary
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    return Semantics(
      button: true,
      enabled: onPressed != null && !isLoading,
      label: text,
      child: SizedBox(
        height: AppConstants.buttonHeight,
        width: width,
        child: type == ButtonType.primary
            ? ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                child: buttonChild,
              )
            : OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                ),
                child: buttonChild,
              ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  outlined,
}
