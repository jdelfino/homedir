#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

dir=${HOME}/config
dotdir=$dir/dotfiles              # dotfiles directory
olddir=${HOME}/dotfiles_old             # old dotfiles backup directory
sublime_dir="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
sublime_backup_dir=~/sublime_user_backup
# this is a dumb change
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p ${olddir}

# change to the dotfiles directory
echo "Changing to the $dir directory ..."
cd ${dir}

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $(find $dotdir -type f -maxdepth 1 -not -name $(basename $0) -exec basename {} ';'); do
	if [[ ! -L ~/${file} ]]
	then
		mv ~/${file} ${olddir}
	else
		cp $(readlink ~/${file}) $olddir/
		rm ~/$file
	fi
    echo "Creating symlink to $file in home directory."
    ln -s ${dotdir}/${file} ~/${file}
done

if [[ ! -L "${sublime_dir}" ]]
then
	echo "Backing sublime /User directory up to ${sublime_backup_dir}"
	mv "${sublime_dir}" "${sublime_backup_dir}"
fi

if [[ ! -e "${sublime_dir}" && ! -L "${sublime_dir}" ]]
then
	echo "Symlink ${sublime_dir} to ${dotdir}/sublime"
	ln -s "${dotdir}"/sublime "${sublime_dir}"
fi
