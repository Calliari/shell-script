# For tab autocompletion


# This line added onto "~/.zshrc" will do the autocompletion when the command starts with 'echo' and press 'TAB-key' from the keyboard.
complete -o default -W "my-dev my-uat my-prod" echo;

When the command 'echo' is typed and TAB is pressed the terminal will prompt for the options[my-dev, my-uat, my-prod], I.E:
```
$ echo my-
my-dev my-uat my-prod
```
