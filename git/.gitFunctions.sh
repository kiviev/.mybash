## Git flow variables
ORIGIN='origin/'
FEATURE='feature/'
BUGFIX='bugfix/'
HOTFIX='hotfix/'
PREFIX='BK-'
PROD_BRANCH='prod'
DEV_BRANCH='master'


## Git complex functions

# change the constants for project
function constants {
  if [ -f ./.gitconfigbash ]; then
    source ./.gitconfigbash
  fi
}

function get_repo(){
  basename -s .git `git config --get remote.origin.url`
}

function print_repo(){
   printText "LIGHT_CYAN" $(get_repo)
}
function git_remote {
  # about 'adds remote $GIT_HOSTING:$1 to current repo'
  # group 'git'

  echo "Running: git remote add origin ${GIT_HOSTING}:$1.git"
  git remote add origin $GIT_HOSTING:$1.git
}

function git_first_push {
  # about 'push into origin refs/heads/master'
  # group 'git'

  echo "Running: git push origin master:refs/heads/master"
  git push origin master:refs/heads/master
}

function git_pub() {
  # about 'publishes current branch to remote origin'
  # group 'git'
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  echo "Publishing ${BRANCH} to remote origin"
  git push -u origin $BRANCH
}

function git_revert() {
  # about 'applies changes to HEAD that revert all changes after this commit'
  # group 'git'

  git reset $1
  git reset --soft HEAD@{1}
  git commit -m "Revert to ${1}"
  git reset --hard
}

function git_rollback() {
  # about 'resets the current HEAD to this commit'
  # group 'git'

  function is_clean() {
    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
      echo "Your branch is dirty, please commit your changes"
      kill -INT $$
    fi
  }

  function commit_exists() {
    git rev-list --quiet $1
    status=$?
    if [ $status -ne 0 ]; then
      echo "Commit ${1} does not exist"
      kill -INT $$
    fi
  }

  function keep_changes() {
    while true
    do
      read -p "Do you want to keep all changes from rolled back revisions in your working tree? [Y/N]" RESP
      case $RESP
      in
      [yY])
        echo "Rolling back to commit ${1} with unstaged changes"
        git reset $1
        break
        ;;
      [nN])
        echo "Rolling back to commit ${1} with a clean working tree"
        git reset --hard $1
        break
        ;;
      *)
        echo "Please enter Y or N"
      esac
    done
  }

  if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    is_clean
    commit_exists $1

    while true
    do
      read -p "WARNING: This will change your history and move the current HEAD back to commit ${1}, continue? [Y/N]" RESP
      case $RESP
        in
        [yY])
          keep_changes $1
          break
          ;;
        [nN])
          break
          ;;
        *)
          echo "Please enter Y or N"
      esac
    done
  else
    echo "you're currently not in a git repository"
  fi
}

function git_remove_missing_files() {
  # about "git rm's missing files"
  # group 'git'

  git ls-files -d -z | xargs -0 git update-index --remove
}

# Adds files to git's exclude file (same as .gitignore)
function local-ignore() {
  # about 'adds file or path to git exclude file'
  # param '1: file or path fragment to ignore'
  # group 'git'
  echo "$1" >> .git/info/exclude
}

# get a quick overview for your git repo
function git_info() {
    # about 'overview for your git repo'
    # group 'git'

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo "git repo overview"
        echo "-----------------"
        echo

        # print all remotes and thier details
        for remote in $(git remote show); do
            echo $remote:
            git remote show $remote
            echo
        done

        # print status of working repo
        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "working directory is clean"
        fi

        # print at least 5 last log entries
        echo
        echo "log:"
        git log -5 --oneline
        echo

    else
        echo "you're currently not in a git repository"

    fi
}

function git_stats {
    # about 'display stats per author'
    # group 'git'

# awesome work from https://github.com/esc/git-stats
# including some modifications

if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    echo "Number of commits per author:"
    git --no-pager shortlog -sn --all
    AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
    LOGOPTS=""
    if [ "$1" == '-w' ]; then
        LOGOPTS="$LOGOPTS -w"
        shift
    fi
    if [ "$1" == '-M' ]; then
        LOGOPTS="$LOGOPTS -M"
        shift
    fi
    if [ "$1" == '-C' ]; then
        LOGOPTS="$LOGOPTS -C --find-copies-harder"
        shift
    fi
    for a in $AUTHORS
    do
        echo '-------------------'
        echo "Statistics for: $a"
        echo -n "Number of files changed: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
        echo -n "Number of lines added: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
        echo -n "Number of lines deleted: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
        echo -n "Number of merges: "
        git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
    done
else
    echo "you're currently not in a git repository"
fi
}

function gittowork() {
  # about 'Places the latest .gitignore file for a given project type in the current directory, or concatenates onto an existing .gitignore'
  # group 'git'
  # param '1: the language/type of the project, used for determining the contents of the .gitignore file'
  # example '$ gittowork java'

  result=$(curl -L "https://www.gitignore.io/api/$1" 2>/dev/null)

  if [[ $result =~ ERROR ]]; then
    echo "Query '$1' has no match. See a list of possible queries with 'gittowork list'"
  elif [[ $1 = list ]]; then
    echo "$result"
  else
    if [[ -f .gitignore ]]; then
      result=`echo "$result" | grep -v "# Created by http://www.gitignore.io"`
      echo ".gitignore already exists, appending..."
      echo "$result" >> .gitignore
    else
      echo "$result" > .gitignore
    fi
  fi
}

function gitignore-reload() {
  # about 'Empties the git cache, and readds all files not blacklisted by .gitignore'
  # group 'git'
  # example '$ gitignore-reload'

    # The .gitignore file should not be reloaded if there are uncommited changes.
  # Firstly, require a clean work tree. The function require_clean_work_tree()
  # was stolen with love from https://www.spinics.net/lists/git/msg142043.html

  # Begin require_clean_work_tree()

  # Update the index
  git update-index -q --ignore-submodules --refresh
  err=0

  # Disallow unstaged changes in the working tree
  if ! git diff-files --quiet --ignore-submodules --
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains unstaged changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  # Disallow uncommited changes in the index
  if ! git diff-index --cached --quiet HEAD --ignore-submodules
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains uncommited changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  # Prompt user to commit or stash changes and exit
  if [ $err = 1 ]
  then
    echo >&2 "Please commit or stash them."
  fi

  # End require_clean_work_tree()

  # If we're here, then there are no uncommited or unstaged changes dangling around.
  # Proceed to reload .gitignore
  if [ $err = 0 ]; then
    # Remove all cached files
    git rm -r --cached .

    # Re-add everything. The changed .gitignore will be picked up here and will exclude the files
    # now blacklisted by .gitignore
    echo >&2 "Running git add ."
    git add .
    echo >&2 "Files readded. Commit your new changes now."
  fi
}

#custom

function gogo() {
  # about 'Go on save mode to a branch and update it -- fetch + checkout + pull'
  # group 'git'
  # param '1: target branch'
  # example '$ gogo $FEATUREXYZ'
  gf
  go $1
  gl
}

function gof() {
  # about 'Go to a feature branch'
  # group 'git'
  # param '1: target branch'
  # param '2: -s for save mode'
  # example '$ gof XYZ'

  if [ "$2" == '-s' ]; then
    gogo $FEATURE$PREFIX$1
  elif [ "$2" == '-b' ]; then
    go $BUGFIX/$PREFIX$1
  elif [ "$2" == '-bs' |  "$2" == '-sb' ]; then
    gogo $FEATUREbugfix/$PREFIX$1
  else
    go $FEATURE$PREFIX$1
  fi
}

function goe() {
  # about 'Go to a epic branch'
  # group 'git'
  # param '1: target branch'
  # param '2: -s for save mode'
  # example '$ goe XYZ'

  if [ "$2" == '-s' ]; then
    gogo epic/$PREFIX$1
  else
    go epic/$PREFIX$1
  fi
}

function create_epic() {
  # about 'Make a epic branch and publish it into origin'
  # group 'git'
  # param '1: epic JIRA ID'
  # example '$ create_epic $PREFIXXYZ'

  gogo master
  go -b epic/$1
  git_pub
}

function git_rename() {
  # about 'rename one branch local and remote'
  # group 'git'
  # param '1: old name'
  # param '2: new name'
  # param '3: options-> -e or -f on epic or feature'
  # example '$ git rename 4056 4056-bck -f'

  if [ "$3" == '-e' ]; then
    R_PREFIX="epic/$PREFIX"
  elif [ "$3" == '-f' ]; then
    PREFIX="$FEATURE$PREFIX"
  else
    R_PREFIX=""
  fi
  OLD_BRANCH="$R_PREFIX$1"
  NEW_BRANCH="$R_PREFIX$2"
  gogo $OLD_BRANCH
  git branch -m $OLD_BRANCH $NEW_BRANCH
  git push origin :$OLD_BRANCH $NEW_BRANCH
}


 # region git flow
 
 function flow_start() 
 {
  # about 'start a new branch accord git flow'
  # group 'git'
  # param '1: Ticket number, without $PREFIX'
  # param '2: Branch type:
  #           -f = feature (default)
  #           -h = hotfix
  #           -r = release
  #           -b = bugfix
  #           -p = personalized (no add $PREFIX)'
  constants
  FOLDER=''
  BASE=$DEV_BRANCH
  THIS_PREFIX=$PREFIX
  if [ "$2" = '-f' ]; then
    FOLDER='feature'
    BASE=$DEV_BRANCH
  elif [ "$2" = '-h' ]; then
    FOLDER='hotfix'
    BASE=$PROD_BRANCH
  elif [ "$2" = '-r' ]; then
    FOLDER='release'
    THIS_PREFIX='v.'
  elif [ "$2" = '-b' ]; then
    FOLDER='bugfix'
  elif [ "$2" = '-p' ]; then
    gogo master
    go -b $1
    return 
  fi
  gogo $BASE
  echo "git flow $FOLDER start $THIS_PREFIX$1"
  git flow $FOLDER start $THIS_PREFIX$1
  # if [ "$2" == '-f']; then
  #   echo "vamos a gof $1"
  #   gof $1
  # fi
 }

 function git_stash(){
  # about 'Stash the changes in a dirty working directory away'
  # group 'git'
  # param '1: Option'
  #           -s = save
  #           -d = drop
  #           -a = apply
  #           -p = pop
  #           -l = list
  #           -sw = show
  #           -clear = clear all list of stashes'
  # param '2: Title or index of stash:
  TYPE=''
  ARG=''
  if [ "$2" != '' ]; then
    ARG=$2
  fi
  if [ "$1" == '-s' ]; then 
    TYPE="save"
    if [ "$2" != '' ]; then
      ARG=$2
    else 
      printText "WARN" "No ha puesto titulo al stash" 
      return
    fi
  elif [ "$1" == '-d' ]; then
      TYPE="drop"
      if [ "$2" != '' ]; then
      ARG=$2
    else 
      printText "WARN" "No ha seleccionado index del stash" 
      return
      fi
  elif [ "$1" == '-a' ]; then
      TYPE="apply"
      if [ "$2" != '' ]; then
      ARG=$2
    else 
      printText "WARN" "No ha seleccionado index del stash" 
      return
    fi
  elif [ "$1" == '-p' ]; then
      TYPE="pop"
    if [ "$2" != '' ]; then
      ARG=$2
    else 
      printText "WARN" "No ha seleccionado index del stash" 
      return
    fi
  elif [ "$1" == '-l' ]; then
      TYPE="list"
  elif [ "$1" == '-sw' ]; then
      TYPE="show"
  elif [ "$1" == '-clear' ]; then
      TYPE="clear"
  fi
  printText "OK" "git stash $TYPE $ARG" 
  git stash $TYPE $ARG
 }


function git_del_origin(){
  # about 'delete a branch in origin repo'
  # group 'git'
  # param '1: Ticket number, without $PREFIX'
  # param '2: Branch type:
  #           -f = feature (default)
  #           -h = hotfix
  #           -r = release
  #           -b = bugfix
  #           -p = personalized (no add $PREFIX)'
  constants
  FOLDER=''
  BASE=$DEV_BRANCH
  THIS_PREFIX=$PREFIX
  if [[ -z $1 || -z $2 ]]; then
    echo "git delete origin sin argumentos"
    return
  fi
  if [ "$1" == '-f' ]; then
    FOLDER='feature'
    BASE=$DEV_BRANCH
  elif [ "$1" == '-h' ]; then
    FOLDER='hotfix'
    BASE=$PROD_BRANCH
  elif [ "$1" == '-r' ]; then
    FOLDER='release'
    THIS_PREFIX='v.'
  elif [ "$1" == '-b' ]; then
    FOLDER='bugfix'
 elif [ "$1" == '-p' ]; then
    echo "git push origin :$2"
    git push origin :$2
    return
  fi
echo "git push origin :$FOLDER/$THIS_PREFIX$2"
   git push origin :$FOLDER/$THIS_PREFIX$2
}

function git_del_local(){
  constants
  FOLDER=''
  BASE=$DEV_BRANCH
  THIS_PREFIX=$PREFIX
  if [[ -z $1 || -z $2 ]]; then
    echo "git delete local sin argumentos"
    return
  fi
  if [ "$1" == '-f' ]; then
    FOLDER='feature'
    BASE=$DEV_BRANCH
  elif [ "$1" == '-h' ]; then
    FOLDER='hotfix'
    BASE=$PROD_BRANCH
  elif [ "$1" == '-r' ]; then
    FOLDER='release'
    THIS_PREFIX='v.'
  elif [ "$1" == '-b' ]; then
    FOLDER='bugfix'
  elif [ "$1" == '-p' ]; then
    echo "git branch -D $2"
    git push origin :$2
    return
  fi
  echo "git branch -D $FOLDER/$THIS_PREFIX$2"
  git branch -D $FOLDER/$THIS_PREFIX$2
}

function git_del_all(){
  git_del_local $1 $2
  git_del_origin $1 $2
}

function git_merge(){
  THIS_ORIGIN=$ORIGIN
  FOLDER=''
  THIS_PREFIX=$PREFIX
  PUB=''
  BRANCH=''
  if [ "$1" == '-om' ]; then
    FOLDER='master'
  elif [ "$1" == '-of' ]; then
    FOLDER="$FEATURE"
    BRANCH="$THIS_PREFIX$2"
  elif [ "$1" == '-f' ]; then
    THIS_ORIGIN=''
    FOLDER="$FEATURE"
    BRANCH="$THIS_PREFIX$2"
  else
    echo 'sin argumentos'
  fi
  if  [ "$2" == '-pub' ] || [ "$3" == '-pub' ] ; then
    PUB="git_pub"
  fi
  echo "git merge $THIS_ORIGIN$FOLDER$BRANCH"
  git merge $THIS_ORIGIN$FOLDER$BRANCH
  if [ "$PUB" != '' ]; then
    $PUB
  fi
}

#la forma de usar es:
# 1- se va al repo que se desee
# 2- se declara el array de las ramas que se desean borrar ramasforedu=(10961 10979 11682 ...)
# 3- se invoca la funcion pej git_del_local_lotes -f ${ramasweb[*]}

function git_del_local_lotes(){
  echo "git del local LOTES"
  FOLDER=''
  if [[ -z $1 || -z $2 ]]; then
    echo "Sin argumentos"
    return
  fi
  declare -a ARRAY=("${@:2}")
  # Get number of elements in the array
  ELEMENTS=${#ARRAY[@]}
    echo "elementos: "$ELEMENTS
    echo "array: "${ARRAY[@]}
  # Echo each element in array
  if [[ "$1" == '-f' || "$1" == '-h' || "$1" == '-r' || "$1" == '-b' || "$1" == '-p' ]]; then
      FOLDER=$1
  else 
    echo "Parametro $1 no valido"
    return
  fi
  if [ "$ELEMENTS" -gt "0" ]; then
    for ((i=0; i<$ELEMENTS; i++)); do
      if [ $FOLDER != '' ]; then
        git_del_local $1 ${ARRAY[${i}]}
      fi
    done
  else 
    echo "$2 o no es un array o no tiene ningun elemento"
  fi

}



function patchToStash(){
  STASHNUM=''
  FILEPATH=''
  # $1 = num of stash in git stash list
  # $2 = ruta y nombre ( sin extension ) donde se creara el fichero .patch
  if [[ $1 != '' && $2 != '' ]]; then 
    STASHNUM=$1
    FILEPATH=$2
  else
    printText 'ERROR' 'ERROR: Sin argumentos'
    return
  fi

  printText "LIGHT_PURPLE" "gstshw -p stash@{$STASHNUM} > $FILEPATH.patch"
  gstshw -p stash@{$STASHNUM} > $FILEPATH.patch
  printText "OK" "OK" 
}

function deleteStashes(){
  if [[ $1 != '' && $2 != '' ]]; then 
    MAX=$2
    MIN=($1 - 1)
    for ((i=$MAX; i>=$MIN; i--)); do
      printText 'OK' 'git_stash -d '${i}
      git_stash -d ${i}
    done
  else 
    printText "ERROR" "Argumentos no validos"
  fi
}