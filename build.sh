#!/bin/bash
#
# build - compile and optionally install mpplus-essentia components
#

usage() {
    printf "\nUsage: ./build [-i] [-d destdir] [-p prefix] [-u] project [project2 ...]"
    printf "\nWhere:"
    printf "\n\t-i indicates install"
    printf "\n\t-d destdir specifies installation destdir (default /)"
    printf "\n\t-p prefix specifies installation prefix (default /usr)"
    printf "\n\t-u displays this usage message and exits\n"
    printf "\n'project' can be 'essentia' or 'gaia'\n"
    exit 1
}

INSTALL=
PREFIX=
DESTDIR=
while getopts "d:ip:u" flag; do
    case $flag in
        d)
            DESTDIR="-d $OPTARG"
            ;;
        i)
            INSTALL="-i"
            ;;
        p)
            PREFIX="-p $OPTARG"
            ;;
        u)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

for project in $*
do
  if [ -x scripts/build-${project}.sh ]
  then
    scripts/build-${project}.sh ${INSTALL} ${DESTDIR} ${PREFIX}
  else
    echo "ERROR: Unrecognized project ${project}. No build script."
  fi
done
