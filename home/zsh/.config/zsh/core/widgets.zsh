# core/widgets.zsh — Load custom ZLE widget definitions.
#
# Widget files load alphabetically.
# Explicit bindings live in keybindings.zsh, sourced afterward.

for _widget_file in "$ZCONFDIR"/widgets/*.zsh(.N); do
  source "$_widget_file"
done

unset _widget_file
