#!/bin/bash

if ! [ -x "$(command -v brew)" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! [ -x "$(command -v jq)" ]; then
  brew install jq
fi

if ! [ -x "$(command -v wget)" ]; then
  brew install wget
fi

if ! [ -x "$(command -v gh)" ]; then
  echo "No GH CLI installed, installing with brew"
  echo "SUDO is required to set up chmods to guarantee uninterrupted installation of GH, please type in your admin password below..."
  echo ""
  echo "-----"
  echo ""
  sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions
  chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
  brew install gh

  echo ""
  echo "-----"
  echo ""
  echo "GH WILL ASK YOU A COUPLE OF QUESTIONS, DEFAULTS BELOW:"
  echo "1. Github.Com"
  echo "2. SSH"
  echo "3. [Enter]"
  echo "4. Login with a web browser"
  echo "5. Paste the code in Github (browser should open)"
  echo ""
  echo "-----"
  echo ""

  gh auth login
fi
