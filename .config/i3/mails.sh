#!/usr/bin/env bash

librewolf -P Email --class Email -new-tab -url https://www.laposte.net/accueil \
  -new-tab -url https://outlook.live.com/mail/0/?prompt=select_account \
  -new-tab -url https://www.gmail.com 

exit 0
