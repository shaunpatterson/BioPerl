# Move music from unsorted directory to top of sorted 
#  directory
find . -name *.mp3 -print0 | xargs -0 -I {} mv {} ~/Music/
