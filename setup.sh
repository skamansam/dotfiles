#!/bin/bash

#username for atom.io/packages, so we can get all [your] starred items
ATOM_USER_NAME=skamansam

# your github username, for cloning all repos for local development
GITHUB_USERNAME=skamansam

# list of extra repos to clone for your workspace
EXTRA_DEV_REPOS=

# list of repos that you are not working on, but want cloned
EXTRA_REPOS=

# directories
TMP_DIR=~/tmp    # downloaded files are here. can be deleted
SRC_DIR=~/src    # source directories are here, so we can build from scratch
WORKSPACE_DIR=~/workspace  # our workspace directory. where our github repos will be stored

# go ahead and create those directories
mkdir $TMP_DIR
mkdir $SRC_DIR
mkdir $WORKSPACE_DIR

report ()
{
  exit_code=$1
  app_name=$2
  if [ $1 eq 0 ]; then
    notify -t "Successfully installed $app_name!"
  else
    notify -t "Did not install $app_name. Check console for info."
  fi
}

echo "downloading rpms"
wget https://atom.io/download/rpm?channel=beta $TMP_DIR/atom.rpm

echo "installing software"
sudo dnf group install "C Development Tools and Libraries"
sudo dnf install git git-cola gnupg2 npm $TMP_DIR/atom.rpm

echo "installing notify"
sudo npm install -g notify-cli
echo "Please enter your notify code from the notify app on your phone: "
read notify_code
notify -r $notify_code
report $? "notify"

echo "configuring and installing rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
report $? "rvm and ruby"

echo "configuring atom"
apm stars --install --user $ATOM_USER_NAME
report $? "$ATOM_USER_NAME's atom plugins"

echo "setting up development workspace"
echo "cloning all $GITHUB_USERNAME's repos"
cd $WORKSPACE_DIR
curl "https://api.github.com/users/$GITHUB_USERNAME/repos" | grep -e 'git_url*' | cut -d \" -f 4 | xargs -L1 git clone
report $? "repos for $GITHUB_USERNAME"
for repo in $EXTRA_DEV_REPOS; do
    echo "Downloading $repo"
    git clone $repo
    report $? "$repo in ~/workspace"
done

echo "cloning extra repos into $HOME/src"
cd $SRC_DIR
for repo in $EXTRA_REPOS; do
    echo "Downloading $repo"
    git clone $repo
    report $? "$repo in ~/src"
done

echo "installing Paper theme for Gtk"
cd $SRC_DIR
git clone https://github.com/snwh/paper-gtk-theme.git
cd paper-gtk-theme
bash install.sh
report $? "Paper theme"

echo "installing Paper icons"
cd $SRC_DIR
git clone https://github.com/snwh/paper-icon-theme.git
cd paper-icon-theme
./install-icon-theme.sh
report $? "Paper icons"

echo "installing Bash-it"
cd $SRC_DIR
git clone https://github.com/Bash-it/bash-it.git
ln -s $SRC_DIR/bash-it ~/.bash_it
report $? "Bash-it"
