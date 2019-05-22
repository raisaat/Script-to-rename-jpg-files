#!/bin/bash
echo "List of files and directories before deletion:"
find . -depth ! '(' -name '*.sh' -o -name '*.txt' -o -name '*.c' -o -name 'Makefile' -o -name '*.o' -o -name 'myprog1' -o -name 'myprog2' ')'
cat > script3.sh << EOF
#!/bin/bash
find . -type l -exec rm -f {} +
find . ! '(' -name '*.sh' -o -name '*.txt' -o -name '*.c' -o -name 'Makefile' -o -name '*.o' -o -name 'myprog1' -o -name 'myprog2' ')' -type f -exec rm -f {} +
rm -Rf -- */
EOF
chmod u+x script3.sh
./script3.sh
echo "List of files and directories after deletion:"
find . -depth ! '(' -name '*.sh' -o -name '*.txt' -o -name '*.c' -o -name 'Makefile' -o -name '*.o' -o -name 'myprog1' -o -name 'myprog2' ')'
