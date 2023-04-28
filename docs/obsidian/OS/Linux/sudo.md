sudo

https://askubuntu.com/questions/192050/how-to-run-sudo-command-with-no-password

最後の行に。順番に意味がある？

```visudo
# ubuntu user is default user in cloud-images.
# It needs passwordless sudo functionality.
USER_NAME ALL=(ALL) NOPASSWD:ALL
```
