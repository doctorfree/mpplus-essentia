#!/bin/bash
#
# build - compile and optionally install essentia
#

usage() {
    printf "\nUsage: ./build [-i] [-d destdir] [-p prefix] [-u]"
    printf "\nWhere:"
    printf "\n\t-i indicates install"
    printf "\n\t-d destdir specifies installation destdir (default /)"
    printf "\n\t-p prefix specifies installation prefix (default /usr)"
    printf "\n\t-u displays this usage message and exits\n"
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

if [ -x scripts/build-essentia.sh ]
then
  scripts/build-essentia.sh ${INSTALL} ${DESTDIR} ${PREFIX}
else
  echo "ERROR: Unrecognized project 'essentia'. No build script."
fi
