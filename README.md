# Script-to-rename-jpg-files

A bash shell script that renames image files in a directory based on their exif data. The script prints usage information when invoked directly, run with the -h or the --help options, and also when incorrect arguments are specified.

### Program details:

The script parses the exif data of all the .jpg files in the current directory and renames them in a manner specified by a command-line argument. The user can choose one of the two following formats to rename them:
1. Rename them in the YYYYMMDD.jpg format based on the day the picture was taken.
2. Rename them in the form of some string specified by the user as a command-line argument and then a number, where they are numbered according to their creation date. For instance, if the string the user specifies is "picture", then the oldest image will be picture000.jpg, the next image will be picture001.jpg and so on.
