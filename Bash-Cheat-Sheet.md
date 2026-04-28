# 🚀 BASH SCRIPTING CHEAT SHEET - Quick Reference

**Use this for quick lookups during your 35-day training!**

---

## 📌 TABLE OF CONTENTS

1. Basics & Syntax
2. Variables & Parameters
3. Operators
4. Conditionals
5. Loops
6. Functions
7. Text Processing
8. File Operations
9. Useful Commands
10. Debugging

---

## 1️⃣ BASICS & SYNTAX

### Script Structure
```bash
#!/bin/bash                    # Shebang (must be first line)

# Comments - ignored by bash
: '
Multi-line comment
using colon and quotes
'

# Code here
echo "Your code"
```

### File Permissions
```bash
chmod +x script.sh            # Make executable
chmod 755 script.sh           # rwxr-xr-x
chmod 700 script.sh           # rwx------
chmod 644 file.txt            # rw-r--r--

ls -l                         # View permissions
```

### Running Scripts
```bash
./script.sh                   # If executable
bash script.sh                # Explicit interpreter
bash -x script.sh             # Debug mode (print commands)
bash -n script.sh             # Check syntax only
```

### Exit Codes
```bash
$?                            # Exit code of last command
0                             # Success
1-255                         # Errors
exit 0                        # Exit with code 0
exit 1                        # Exit with code 1
```

---

## 2️⃣ VARIABLES & PARAMETERS

### Variable Declaration & Usage
```bash
name="John"                   # Declare (no spaces around =)
echo $name                    # Expand (with $)
echo ${name}                  # Expand (safer with braces)
echo "$name"                  # Expand in quotes
echo '$name'                  # Single quotes = literal (no expansion)
```

### Environment Variables
```bash
$HOME        # User home directory
$PATH        # Executable search paths
$USER        # Current user
$SHELL       # Current shell
$PWD         # Present working directory
$OLDPWD      # Previous directory
$HOSTNAME    # Machine hostname
$UID         # User ID
$RANDOM      # Random number (0-32767)
$SECONDS     # Seconds since script start
```

### Command Arguments
```bash
$0           # Script name
$1, $2, ..., $9    # First to ninth argument
${10}        # Tenth argument (need braces)
$#           # Number of arguments
$@           # All arguments (as array)
$*           # All arguments (as string)
shift        # Move to next argument
```

### Parameter Expansion
```bash
${var:-default}         # Use default if var empty
${var:=default}         # Assign default if var empty
${var:?error}           # Error if var empty
${#var}                 # Length of variable
${var:0:5}              # Substring (first 5 chars)
${var:(-3)}             # Last 3 characters
${var#pattern}          # Remove shortest match (start)
${var##pattern}         # Remove longest match (start)
${var%pattern}          # Remove shortest match (end)
${var%%pattern}         # Remove longest match (end)
${var/old/new}          # Replace first occurrence
${var//old/new}         # Replace all occurrences
${var^}                 # Capitalize first letter
${var^^}                # Capitalize all letters
${var,}                 # Lowercase first letter
${var,,}                # Lowercase all letters
```

### Variable Types
```bash
# Strings (default)
name="Alice"

# Numbers (arithmetic context)
count=5
result=$((count + 2))

# Arrays
fruits=(apple banana orange)
fruits+=("mango")

# Associative arrays (bash 4+)
declare -A person
person[name]="John"
person[age]=30
```

---

## 3️⃣ OPERATORS

### Arithmetic Operators
```bash
$((5 + 3))              # Addition = 8
$((10 - 4))             # Subtraction = 6
$((3 * 4))              # Multiplication = 12
$((20 / 4))             # Division = 5
$((20 % 3))             # Modulo (remainder) = 2
$((2 ** 3))             # Exponentiation = 8

# Increment/Decrement
$((++count))            # Pre-increment
$((count++))            # Post-increment
$((--count))            # Pre-decrement
$((count--))            # Post-decrement
```

### Comparison Operators (Integers)
```bash
-eq        # Equal
-ne        # Not equal
-lt        # Less than
-le        # Less than or equal
-gt        # Greater than
-ge        # Greater than or equal
```

**Usage:**
```bash
if [ $count -eq 5 ]; then
    echo "Count is 5"
fi
```

### String Comparison
```bash
=          # Equal (use in [[ ]])
!=         # Not equal
-z         # Zero length (empty)
-n         # Non-zero length (not empty)
```

**Usage:**
```bash
if [ "$name" = "John" ]; then
    echo "Hello John"
fi
```

### Logical Operators
```bash
&&         # AND
||         # OR
!          # NOT
```

**Usage:**
```bash
if [ $age -gt 18 ] && [ $age -lt 65 ]; then
    echo "Working age"
fi
```

### File Test Operators
```bash
-e         # File exists
-f         # Regular file
-d         # Directory
-L         # Symbolic link
-s         # File exists and not empty
-r         # Readable
-w         # Writable
-x         # Executable
-O         # Owned by user
-G         # Owned by group
```

**Usage:**
```bash
if [ -f "$file" ]; then
    echo "File exists and is regular file"
fi
```

---

## 4️⃣ CONDITIONALS

### if-then-else
```bash
if condition; then
    # commands if true
fi

if condition; then
    # commands if true
else
    # commands if false
fi

if condition1; then
    # commands
elif condition2; then
    # commands
else
    # commands
fi
```

### [[ ]] vs [ ]
```bash
[ condition ]          # POSIX shell (more portable)
[[ condition ]]        # Bash only (more powerful)

# [[ ]] allows:
[[ $var == pattern* ]]  # Pattern matching
[[ $var =~ regex ]]     # Regular expressions
[[ $var && $var2 ]]     # Logical operators without quotes
```

### case Statement
```bash
case "$var" in
    pattern1)
        # commands
        ;;
    pattern2|pattern3)
        # commands (multiple patterns)
        ;;
    *)
        # default case
        ;;
esac
```

**Pattern Examples:**
```bash
case "$file" in
    *.txt)
        echo "Text file"
        ;;
    *.jpg|*.png)
        echo "Image file"
        ;;
    *)
        echo "Unknown file"
        ;;
esac
```

---

## 5️⃣ LOOPS

### for Loop (C-style)
```bash
for ((i=0; i<5; i++)); do
    echo "Number: $i"
done
```

### for Loop (iterate list)
```bash
for item in one two three; do
    echo "$item"
done

for item in $(command); do
    # item from command output
done

for item in ${array[@]}; do
    # item from array
done
```

### while Loop
```bash
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

### until Loop
```bash
count=0
until [ $count -eq 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

### Loop Control
```bash
break       # Exit loop immediately
continue    # Skip to next iteration
```

---

## 6️⃣ FUNCTIONS

### Define Function
```bash
function_name() {
    # commands
    return 0
}

# Or with function keyword
function function_name {
    # commands
}
```

### Function with Parameters
```bash
greet() {
    local name=$1
    local greeting=$2
    echo "$greeting, $name!"
}

greet "Alice" "Hello"
```

### Return Values
```bash
get_status() {
    if [ -f "/var/lock/service" ]; then
        return 0    # Success
    else
        return 1    # Failure
    fi
}

if get_status; then
    echo "Service running"
fi
```

### Capture Output
```bash
result=$(function_name)
echo "Result: $result"
```

### Local Variables
```bash
my_function() {
    local var="local scope"
    global_var="global scope"
}
```

---

## 7️⃣ TEXT PROCESSING

### grep - Search Text
```bash
grep "pattern" file.txt
grep -i "pattern" file.txt         # Case-insensitive
grep -v "pattern" file.txt         # Invert (not matching)
grep -c "pattern" file.txt         # Count matches
grep -n "pattern" file.txt         # Show line numbers
grep -l "pattern" *.txt            # Show filenames only
grep -A 3 "pattern" file.txt       # 3 lines after
grep -B 2 "pattern" file.txt       # 2 lines before
grep -E "regex" file.txt           # Extended regex
grep -o "pattern" file.txt         # Only matching part
```

### sed - Stream Editor
```bash
sed 's/old/new/' file.txt          # Replace first per line
sed 's/old/new/g' file.txt         # Replace all (global)
sed 's/old/new/2' file.txt         # Replace 2nd occurrence
sed 's/old/new/gi' file.txt        # Case-insensitive replace
sed '/pattern/d' file.txt          # Delete lines matching
sed '5d' file.txt                  # Delete line 5
sed '/pattern/a New line' file.txt # Append after pattern
sed '/pattern/i New line' file.txt # Insert before pattern
sed -n '5,10p' file.txt            # Print lines 5-10 only
sed -i.bak 's/old/new/g' file.txt # In-place with backup
```

### awk - Text Processing
```bash
awk '{print $1}' file.txt          # Print first field
awk -F: '{print $1}' file.txt      # Custom field separator
awk '{print NF}' file.txt          # Number of fields
awk '{print NR}' file.txt          # Line number
awk '/pattern/ {print}' file.txt   # Lines matching pattern
awk '$3 > 100 {print}' file.txt    # If 3rd field > 100
awk '{sum+=$1} END {print sum}' file.txt  # Sum column
```

### cut - Extract Columns
```bash
cut -d: -f1 /etc/passwd            # First field with : delimiter
cut -c1-5 file.txt                 # First 5 characters
cut -f2 file.txt                   # Second tab-separated field
```

### sort, uniq, wc
```bash
sort file.txt                      # Sort lines
sort -n file.txt                   # Numeric sort
sort -r file.txt                   # Reverse sort
sort -u file.txt                   # Sort unique
uniq file.txt                      # Remove duplicates
uniq -c file.txt                   # Count occurrences
wc -l file.txt                     # Count lines
wc -w file.txt                     # Count words
wc -c file.txt                     # Count bytes
```

---

## 8️⃣ FILE OPERATIONS

### Read/Write Files
```bash
# Read
cat file.txt                       # Display file
cat file.txt | less                # Paginated view
head -10 file.txt                  # First 10 lines
tail -10 file.txt                  # Last 10 lines
tail -f file.txt                   # Follow (live updates)

# Write
echo "text" > file.txt             # Overwrite
echo "text" >> file.txt            # Append
cat > file.txt << EOF
Multiple
lines
EOF

# Combine
cat file1.txt file2.txt > combined.txt
```

### File Operations
```bash
ls                                 # List files
ls -la                             # List with details
mkdir dirname                      # Create directory
mkdir -p dir/subdir                # Create nested
cp file.txt copy.txt               # Copy file
cp -r dir newdir                   # Copy directory
mv file.txt newname.txt            # Move/rename
rm file.txt                        # Delete file
rm -r directory                    # Delete directory
find . -name "*.txt"               # Find files
find . -type f -size +1M           # Find large files
```

### Piping & Redirection
```bash
command1 | command2                # Pipe output
command > file.txt                 # Redirect stdout
command 2> error.txt               # Redirect stderr
command &> all.txt                 # Redirect both
command >> file.txt                # Append stdout
< file.txt                         # Read from file
```

---

## 9️⃣ USEFUL COMMANDS

### String Operations
```bash
echo "text"                        # Print
printf "%s\n" "text"               # Formatted print
basename /path/to/file             # Filename only
dirname /path/to/file              # Directory only
```

### Date/Time
```bash
date                               # Current date/time
date +%Y-%m-%d                     # Specific format
date +%s                           # Unix timestamp
sleep 5                            # Sleep 5 seconds
```

### Process Management
```bash
ps aux                             # List processes
ps aux | grep bash                 # Find bash processes
kill 1234                          # Kill process by ID
jobs                               # List background jobs
fg                                 # Bring to foreground
bg                                 # Run in background
```

### System Information
```bash
whoami                             # Current user
hostname                           # Machine name
uname -a                           # OS information
df -h                              # Disk usage
du -sh dirname                     # Directory size
free -h                            # Memory usage
uptime                             # System uptime
```

### Useful Tricks
```bash
which command                      # Find command location
type command                       # Command type
history                            # Command history
source script.sh                   # Execute in current shell
```

---

## 🔟 DEBUGGING

### Debug Options
```bash
bash -n script.sh                  # Syntax check
bash -v script.sh                  # Print commands
bash -x script.sh                  # Print + execute

set -x                             # Enable debugging in script
set +x                             # Disable debugging
set -e                             # Exit on error
set -u                             # Error on undefined vars
set -o pipefail                    # Pipe fails on error
```

### Print Debugging
```bash
echo "DEBUG: var = $var"           # Print variable
echo "DEBUG: reached line X"       # Track execution
```

### Check Exit Codes
```bash
command
echo $?                            # Check result (0=success)

command || echo "Failed"
command && echo "Success"
```

### Trap & Error Handling
```bash
trap 'echo Error on line $LINENO' ERR
trap 'cleanup' EXIT

cleanup() {
    rm -f /tmp/temp_file
    echo "Cleaned up"
}
```

---

## ⚡ QUICK SNIPPETS

### Check if file exists
```bash
if [ -f "$file" ]; then
    echo "File exists"
fi
```

### Check if directory exists
```bash
if [ -d "$dir" ]; then
    echo "Directory exists"
fi
```

### Loop through files
```bash
for file in *.txt; do
    echo "Processing $file"
done
```

### Read file line by line
```bash
while IFS= read -r line; do
    echo "$line"
done < "$file"
```

### Count lines in file
```bash
wc -l < "$file"
```

### Get first parameter with default
```bash
filename="${1:-default.txt}"
```

### Check if string is empty
```bash
if [ -z "$var" ]; then
    echo "Variable is empty"
fi
```

### Check if string is not empty
```bash
if [ -n "$var" ]; then
    echo "Variable has content"
fi
```

### Convert to lowercase
```bash
echo "${var,,}"
```

### Convert to uppercase
```bash
echo "${var^^}"
```

### Trim whitespace
```bash
var="${var#  }"        # Remove leading spaces
var="${var%  }"        # Remove trailing spaces
```

---

## 🎯 MOST COMMON MISTAKES

| Mistake | Correct |
|---------|---------|
| `if [ $x=5 ]` | `if [ $x -eq 5 ]` |
| `var = "value"` | `var="value"` |
| `for i in 1..10` | `for ((i=1; i<=10; i++))` |
| `$(cmd) &` | `$(cmd &)` or `background_cmd &` |
| `echo $1 $2` (unquoted) | `echo "$1" "$2"` (quoted) |
| `test -z $var` | `test -z "$var"` (quote empty vars) |

---

## 📖 CHEAT SHEET USAGE TIPS

- **Print this:** Use as physical reference during coding
- **Bookmark:** Keep in browser for quick lookup
- **Search:** Use Ctrl+F to find what you need
- **Copy-Paste:** Modify examples for your use case
- **Practice:** Type examples by hand to build muscle memory

**Bookmark these sections:**
- ⭐ #2 Variables & Parameters (most used)
- ⭐ #4 Conditionals (critical for scripts)
- ⭐ #7 Text Processing (DevOps essential)
- ⭐ #9 Useful Commands (daily helpers)

---

## 🔗 RELATED RESOURCES

During your 35-day training, refer to:
- Full curriculum: `35-Day-DevOps-Bash-Mastery.md`
- Daily progress: `Daily-Progress-Tracker.md`
- Day 1 quick start: `Day-1-Quick-Start.md`

---

**Last Updated:** For Bash 4.0+  
**Compatible:** macOS, Linux, WSL

Good luck with your DevOps bash scripting journey! 🚀

