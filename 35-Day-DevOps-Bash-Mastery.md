# 35-Day DevOps Bash Scripting Mastery Program
**Level:** Basic → Interview Ready | **Commitment:** 1-2 hours/day | **Target:** All DevOps Domains

---

## 📅 Program Overview

| Week | Focus | Days | Key Outcome |
|------|-------|------|------------|
| 1 | Fundamentals & Basics | 1-5 | Variables, operators, script structure |
| 1-2 | Control Structures | 6-10 | Conditionals, loops, patterns |
| 2-3 | Functions & Modularity | 11-15 | Reusable code, function handling |
| 3-4 | Advanced Text Processing | 16-20 | sed, awk, grep, data transformation |
| 4-5 | DevOps Scenarios | 21-30 | Real-world automation scripts |
| 5 | Interview Prep & Projects | 31-35 | Mock interviews, portfolio projects |

---

## 🎯 WEEK 1: BASH FUNDAMENTALS (Days 1-5)

### Day 1: Script Basics & Environment
**Topics:** Shebang, chmod, script execution, environment variables

**Concepts:**
```bash
#!/bin/bash                    # Shebang - tells system to use bash
chmod +x script.sh            # Make executable
./script.sh                   # Run directly
bash script.sh                # Run with bash explicitly
```

**Key Environment Variables:**
```bash
$HOME      # User's home directory
$PATH      # Executable search paths
$USER      # Current user
$SHELL     # Current shell
$PWD       # Present working directory
$?         # Exit status of last command
$#         # Number of arguments
$@         # All arguments
$0         # Script name
```

**Today's Exercise:**
Create a script that displays your environment information
```bash
#!/bin/bash
echo "=== Your Environment ==="
echo "User: $USER"
echo "Home: $HOME"
echo "Current Shell: $SHELL"
echo "Working Directory: $PWD"
echo "Script Name: $0"
```

**Interview Question:** *What is the shebang and why is it important?*
> The shebang (#!) is the first line that tells the OS which interpreter to use. It's crucial for direct script execution (./script.sh). Without it, the system won't know to use bash.

---

### Day 2: Variables, Data Types & Operators
**Topics:** Variable declaration, string/numeric operations, arithmetic

**Key Concepts:**
```bash
# Variables (no spaces around =)
name="John"
age=30
PI=3.14

# Variable expansion
echo $name              # John
echo ${name}           # John (safer)
echo "Hello, $name"    # Hello, John

# Arithmetic
num=$((5 + 3))        # 8
result=$[10 - 2]      # 8
count=$((count + 1))  # Increment

# String concatenation
full_name="$first_name $last_name"
message="Hello"${message}" World"

# Comparison operators
-eq  # Equal
-ne  # Not equal
-lt  # Less than
-gt  # Greater than
-le  # Less or equal
-ge  # Greater or equal

# String comparison
=  # Equals
!= # Not equals
-z # Zero length (empty)
-n # Non-zero length
```

**Exercise: Create a script that takes two numbers and performs operations**
```bash
#!/bin/bash
echo "Enter first number: "
read num1
echo "Enter second number: "
read num2

sum=$((num1 + num2))
diff=$((num1 - num2))
product=$((num1 * num2))

echo "Sum: $sum"
echo "Difference: $diff"
echo "Product: $product"

if [ $num1 -gt $num2 ]; then
    echo "$num1 is greater than $num2"
else
    echo "$num2 is greater than or equal to $num1"
fi
```

**Interview Question:** *What's the difference between $var and ${var}?*
> Both expand the variable, but ${var} is safer in contexts like "${var}suffix" where ambiguity might arise. ${var} is also required for advanced expansions like ${var:0:5}.

---

### Day 3: Command Substitution & Input/Output
**Topics:** Command substitution, input handling, redirection

**Key Concepts:**
```bash
# Command substitution (two methods)
files=$(ls -la)        # Modern syntax (preferred)
files=`ls -la`         # Old syntax (avoid)

# Input methods
read var              # Read from stdin
read -p "Prompt: " var  # With prompt
read -s password      # Silent input (no echo)
read -r line          # Raw input (preserve backslashes)

# Output redirection
echo "text" > file.txt       # Overwrite
echo "text" >> file.txt      # Append
echo "text" 2> error.log     # Redirect error (stderr)
echo "text" &> all.log       # Redirect all output

# Here documents (multiline input)
cat << EOF
This is a
multiline
string
EOF
```

**Exercise: Create a system info script**
```bash
#!/bin/bash
echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Kernel Version: $(uname -r)"
echo "Disk Usage:"
df -h | head -5
echo ""
echo "Memory Usage:"
free -h | head -2
```

**Interview Question:** *What's the difference between > and >>?*
> `>` overwrites the file (creates if not exists), while `>>` appends to the file. Using `>` on an existing file destroys its content.

---

### Day 4: Conditional Statements (If/Else/Elif)
**Topics:** Test conditions, if-else structures, file testing

**Key Concepts:**
```bash
# Basic if-then
if [ condition ]; then
    # commands
fi

# if-else
if [ condition ]; then
    # command if true
else
    # command if false
fi

# if-elif-else
if [ $age -lt 13 ]; then
    echo "Child"
elif [ $age -lt 18 ]; then
    echo "Teenager"
else
    echo "Adult"
fi

# File testing operators
-e file    # File exists
-f file    # Regular file
-d dir     # Directory exists
-s file    # File exists and not empty
-r file    # File is readable
-w file    # File is writable
-x file    # File is executable

# Logical operators
&&  # AND
||  # OR
!   # NOT

# Examples
if [ -f "$file" ] && [ -r "$file" ]; then
    echo "File exists and is readable"
fi

if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
fi
```

**Exercise: Backup script with checks**
```bash
#!/bin/bash
source_dir="/home/user/documents"
backup_dir="/backup/documents"

# Check if source exists
if [ ! -d "$source_dir" ]; then
    echo "ERROR: Source directory does not exist!"
    exit 1
fi

# Create backup if it doesn't exist
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
    echo "Created backup directory"
fi

# Perform backup
if cp -r "$source_dir"/* "$backup_dir/"; then
    echo "Backup successful"
    echo "Backed up to: $backup_dir"
else
    echo "Backup failed!"
    exit 1
fi
```

**Interview Question:** *What does 'set -e' do in a bash script?*
> `set -e` causes the script to exit immediately if any command exits with a non-zero status (error). This prevents cascading failures in scripts.

---

### Day 5: Loops (for, while, until)
**Topics:** Loop structures, iteration patterns, loop control

**Key Concepts:**
```bash
# For loop - C style
for ((i=0; i<5; i++)); do
    echo "Number: $i"
done

# For loop - iterate over list/array
for item in one two three; do
    echo "$item"
done

# For loop - iterate over command output
for file in $(ls *.txt); do
    echo "Processing: $file"
done

# While loop
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done

# Until loop (opposite of while)
count=0
until [ $count -eq 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done

# Loop control
break    # Exit loop
continue # Skip to next iteration
```

**Exercise: Batch file processor**
```bash
#!/bin/bash
directory="${1:-.}"  # Default to current directory

if [ ! -d "$directory" ]; then
    echo "ERROR: Directory does not exist"
    exit 1
fi

echo "Files in $directory:"
count=0

for file in "$directory"/*; do
    if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        echo "  $((count + 1)). $(basename $file) - $size bytes"
        count=$((count + 1))
    fi
done

echo "Total files: $count"
```

**Interview Question:** *What's the difference between for and while loops?*
> `for` loops are best for iterating over known collections (arrays, files, ranges), while `while` loops are better for conditional iteration where the number of iterations isn't known upfront.

---

## 🎯 WEEK 2: CONTROL STRUCTURES & PATTERNS (Days 6-10)

### Day 6: Case Statements & Pattern Matching
**Topics:** Case statements, pattern matching, menu scripts

**Key Concepts:**
```bash
# Case statement
case "$var" in
    pattern1)
        # commands
        ;;
    pattern2|pattern3)  # Multiple patterns
        # commands
        ;;
    *)  # Default case
        # commands
        ;;
esac

# Examples
case "$1" in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

# Pattern matching with wildcards
case "$filename" in
    *.txt)
        echo "Text file"
        ;;
    *.jpg|*.png)
        echo "Image file"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac
```

**Exercise: Service management script**
```bash
#!/bin/bash
SERVICE="nginx"

case "${1:-status}" in
    start)
        echo "Starting $SERVICE..."
        systemctl start $SERVICE
        ;;
    stop)
        echo "Stopping $SERVICE..."
        systemctl stop $SERVICE
        ;;
    restart)
        echo "Restarting $SERVICE..."
        systemctl restart $SERVICE
        ;;
    status)
        systemctl status $SERVICE
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
```

**Interview Question:** *Why use case statements over multiple if-elif?*
> Case statements are cleaner, more readable, and faster for matching against multiple patterns. They're the idiomatic way to implement state machines or command dispatchers in bash.

---

### Day 7: Arrays & String Operations
**Topics:** Arrays, string manipulation, array iteration

**Key Concepts:**
```bash
# Array declaration
fruits=(apple banana orange)
numbers=(1 2 3 4 5)

# Accessing array elements
echo ${fruits[0]}        # apple
echo ${fruits[@]}        # All elements
echo ${#fruits[@]}       # Array length

# Adding elements
fruits+=(mango)

# Array iteration
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# String operations
str="DevOps Engineer"
echo ${#str}             # Length: 15
echo ${str:0:6}          # Substring: DevOps
echo ${str#Dev}          # Remove prefix: Ops Engineer
echo ${str%Engineer}     # Remove suffix: DevOps 
echo ${str/Ops/Cloud}    # Replace: DevCloud Engineer

# Parameter expansion
${var:-default}          # Use default if var is empty
${var:=default}          # Assign default if empty
${var:?Error message}    # Error if empty
${var#pattern}           # Remove shortest match from start
${var##pattern}          # Remove longest match from start
${var%pattern}           # Remove shortest match from end
${var%%pattern}          # Remove longest match from end
```

**Exercise: Log analyzer script**
```bash
#!/bin/bash
logfile="${1:-/var/log/auth.log}"

if [ ! -f "$logfile" ]; then
    echo "ERROR: Log file not found"
    exit 1
fi

# Array to store failed logins
declare -a failed_users
declare -a failed_ips

count=0
while IFS= read -r line; do
    if [[ "$line" == *"Failed password"* ]]; then
        # Extract username and IP
        username=$(echo "$line" | grep -oP '(?<=user=)\w+' || echo "unknown")
        ip=$(echo "$line" | grep -oP '\d+\.\d+\.\d+\.\d+' | head -1)
        
        failed_users+=("$username")
        failed_ips+=("$ip")
        count=$((count + 1))
    fi
done < "$logfile"

echo "Total failed login attempts: $count"
echo ""
echo "Failed users:"
printf '%s\n' "${failed_users[@]}" | sort | uniq -c

echo ""
echo "IPs with failed attempts:"
printf '%s\n' "${failed_ips[@]}" | sort | uniq -c
```

**Interview Question:** *How do you safely iterate over array elements?*
> Use `for item in "${array[@]}"` with quotes. Without quotes, word splitting can cause elements with spaces to be split incorrectly.

---

### Day 8: Functions & Modularity
**Topics:** Function definition, parameters, return values, scope

**Key Concepts:**
```bash
# Function definition
function function_name() {
    # commands
    return 0  # Optional return value (0-255)
}

# Or simpler syntax
function_name() {
    # commands
}

# Function with parameters
greet() {
    local greeting=$1
    local name=$2
    echo "$greeting, $name!"
}

# Function return values
get_status() {
    if [ -f "/var/lock/service.lock" ]; then
        return 0  # Running
    else
        return 1  # Not running
    fi
}

# Using return values
if get_status; then
    echo "Service is running"
else
    echo "Service is not running"
fi

# Capturing output
result=$(get_ip)
echo "IP Address: $result"

# Variable scope
global_var="I'm global"

set_local() {
    local local_var="I'm local"
    echo "Inside function: $local_var"
    echo "Global: $global_var"
}

# Local variable doesn't exist outside function
```

**Exercise: System administration functions**
```bash
#!/bin/bash

# Check if user is root
require_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "ERROR: This script must be run as root"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
    return $?
}

# Log messages with timestamp
log_message() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message"
}

# Check if service is running
is_service_running() {
    local service=$1
    systemctl is-active --quiet "$service"
}

# Main script
require_root

if command_exists nginx; then
    log_message "INFO" "Nginx is installed"
    
    if is_service_running nginx; then
        log_message "INFO" "Nginx is running"
    else
        log_message "WARN" "Nginx is not running"
        log_message "INFO" "Starting nginx..."
        systemctl start nginx
    fi
else
    log_message "ERROR" "Nginx is not installed"
fi
```

**Interview Question:** *What's the difference between local and global variables?*
> Local variables (declared with `local`) exist only within a function's scope. Global variables are accessible throughout the script. Using local prevents unintended side effects.

---

### Day 9: Error Handling & Debugging
**Topics:** Exit codes, error handling, debugging techniques, set options

**Key Concepts:**
```bash
# Check command success
if ! command; then
    echo "Command failed with exit code: $?"
    exit 1
fi

# Set options for safety
set -e   # Exit on error
set -u   # Exit on undefined variable
set -o pipefail  # Pipe fails if any command fails
set -x   # Print commands before executing (debugging)

# Trap errors
trap 'echo "Error on line $LINENO"' ERR
trap 'cleanup' EXIT

cleanup() {
    rm -f /tmp/temp_file
    echo "Cleanup completed"
}

# Error messages to stderr
echo "This is an error" >&2

# Checking for undefined variables
if [ -z "${VAR:-}" ]; then
    echo "VAR is not set"
fi

# Validate input
validate_input() {
    if [ $# -lt 2 ]; then
        echo "ERROR: Missing arguments"
        echo "Usage: $0 <arg1> <arg2>"
        return 1
    fi
}
```

**Exercise: Robust deployment script**
```bash
#!/bin/bash

set -euo pipefail

# Configuration
DEPLOY_USER="deploy"
APP_PATH="/opt/myapp"
BACKUP_PATH="/backups"

# Error handler
error_exit() {
    echo "ERROR: $1" >&2
    cleanup
    exit 1
}

# Cleanup function
cleanup() {
    echo "Performing cleanup..."
    # Remove temporary files
    rm -rf /tmp/deploy_*
}

trap cleanup EXIT
trap 'error_exit "Error on line $LINENO"' ERR

# Validate requirements
validate_requirements() {
    local required_commands=("git" "systemctl" "tar")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            error_exit "Required command '$cmd' not found"
        fi
    done
}

# Backup current app
backup_app() {
    if [ ! -d "$APP_PATH" ]; then
        echo "WARN: App directory doesn't exist, skipping backup"
        return 0
    fi
    
    local backup_file="$BACKUP_PATH/app_$(date +%Y%m%d_%H%M%S).tar.gz"
    mkdir -p "$BACKUP_PATH"
    tar -czf "$backup_file" -C "$APP_PATH" . || error_exit "Backup failed"
    echo "Backup created: $backup_file"
}

# Deploy application
deploy_app() {
    echo "Deploying application..."
    cd "$APP_PATH"
    git pull origin main || error_exit "Git pull failed"
    
    # Run any deployment commands
    if [ -f "deploy.sh" ]; then
        bash deploy.sh || error_exit "Deployment script failed"
    fi
    
    echo "Deployment completed"
}

# Main
main() {
    validate_requirements
    backup_app
    deploy_app
    echo "Application deployed successfully"
}

main "$@"
```

**Interview Question:** *What does `set -e` do and when would you use it?*
> `set -e` exits the script immediately if any command returns a non-zero exit code. This prevents errors from cascading through dependent commands. However, be careful with commands that return non-zero for valid reasons.

---

### Day 10: Practice Project - Automated Backup Script
**Topics:** Integration of all Week 1-2 concepts

**Project: Create a comprehensive backup solution**

```bash
#!/bin/bash

# =============================================================================
# Automated Backup Script for DevOps
# Purpose: Backup directories with rotation, compression, and validation
# =============================================================================

set -euo pipefail

# Configuration
readonly BACKUP_SOURCE="${BACKUP_SOURCE:-.}"
readonly BACKUP_DEST="${BACKUP_DEST:-./backups}"
readonly RETENTION_DAYS="${RETENTION_DAYS:-7}"
readonly LOG_FILE="${LOG_FILE:-./backup.log}"

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Logging function
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Print colored output
print_status() {
    local status=$1
    local message=$2
    
    case "$status" in
        success)
            echo -e "${GREEN}✓${NC} $message"
            ;;
        error)
            echo -e "${RED}✗${NC} $message"
            ;;
        warning)
            echo -e "${YELLOW}!${NC} $message"
            ;;
    esac
}

# Validate prerequisites
validate_environment() {
    log "INFO" "Validating environment..."
    
    # Check if source directory exists
    if [ ! -d "$BACKUP_SOURCE" ]; then
        log "ERROR" "Source directory does not exist: $BACKUP_SOURCE"
        return 1
    fi
    
    # Create backup destination if it doesn't exist
    if [ ! -d "$BACKUP_DEST" ]; then
        mkdir -p "$BACKUP_DEST" || {
            log "ERROR" "Failed to create backup destination"
            return 1
        }
        log "INFO" "Created backup destination: $BACKUP_DEST"
    fi
    
    # Check available disk space
    local available_space=$(df "$BACKUP_DEST" | awk 'NR==2 {print $4}')
    local source_size=$(du -s "$BACKUP_SOURCE" | awk '{print $1}')
    
    if [ "$available_space" -lt "$source_size" ]; then
        log "WARNING" "Low disk space. Available: $available_space KB, Needed: $source_size KB"
    fi
    
    print_status "success" "Environment validation passed"
    return 0
}

# Perform backup
perform_backup() {
    log "INFO" "Starting backup..."
    
    local backup_name="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    local backup_path="$BACKUP_DEST/$backup_name"
    
    if tar -czf "$backup_path" -C "$(dirname "$BACKUP_SOURCE")" "$(basename "$BACKUP_SOURCE")" 2>/dev/null; then
        local backup_size=$(du -h "$backup_path" | awk '{print $1}')
        log "INFO" "Backup created: $backup_name (Size: $backup_size)"
        print_status "success" "Backup completed: $backup_name"
        echo "$backup_path"
        return 0
    else
        log "ERROR" "Backup failed"
        print_status "error" "Backup creation failed"
        return 1
    fi
}

# Validate backup integrity
validate_backup() {
    local backup_file=$1
    log "INFO" "Validating backup: $(basename $backup_file)"
    
    if tar -tzf "$backup_file" &> /dev/null; then
        log "INFO" "Backup validation passed"
        print_status "success" "Backup integrity verified"
        return 0
    else
        log "ERROR" "Backup validation failed"
        print_status "error" "Backup is corrupted"
        return 1
    fi
}

# Cleanup old backups (rotation)
cleanup_old_backups() {
    log "INFO" "Cleaning up backups older than $RETENTION_DAYS days..."
    
    local count=0
    while IFS= read -r backup_file; do
        rm -f "$backup_file"
        log "INFO" "Deleted old backup: $(basename $backup_file)"
        count=$((count + 1))
    done < <(find "$BACKUP_DEST" -name "backup_*.tar.gz" -mtime "+$RETENTION_DAYS")
    
    if [ $count -gt 0 ]; then
        log "INFO" "Removed $count old backup(s)"
        print_status "success" "Cleanup completed: Removed $count old backup(s)"
    else
        log "INFO" "No old backups to remove"
    fi
}

# Generate backup report
generate_report() {
    log "INFO" "Generating backup report..."
    
    echo ""
    echo "==================================="
    echo "Backup Report - $(date '+%Y-%m-%d %H:%M:%S')"
    echo "==================================="
    echo "Source: $BACKUP_SOURCE"
    echo "Destination: $BACKUP_DEST"
    echo "Retention Days: $RETENTION_DAYS"
    echo ""
    echo "Backups in storage:"
    
    local total_size=0
    local count=0
    
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            local size=$(du -h "$file" | awk '{print $1}')
            local mtime=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$file" 2>/dev/null || stat -c "%y" "$file" 2>/dev/null | cut -d' ' -f1,2)
            echo "  - $(basename $file) ($size) - Modified: $mtime"
            count=$((count + 1))
        fi
    done < <(find "$BACKUP_DEST" -name "backup_*.tar.gz" -type f | sort -r)
    
    if [ $count -eq 0 ]; then
        echo "  (No backups found)"
    else
        total_size=$(du -sh "$BACKUP_DEST" | awk '{print $1}')
        echo ""
        echo "Total backups: $count"
        echo "Total size: $total_size"
    fi
    
    echo "==================================="
    echo ""
}

# Main function
main() {
    log "INFO" "Backup script started by $USER"
    
    if ! validate_environment; then
        log "ERROR" "Environment validation failed"
        exit 1
    fi
    
    local backup_file
    if backup_file=$(perform_backup); then
        if validate_backup "$backup_file"; then
            cleanup_old_backups
            generate_report
            log "INFO" "Backup script completed successfully"
            print_status "success" "Backup process completed"
            exit 0
        else
            log "ERROR" "Backup validation failed"
            exit 1
        fi
    else
        log "ERROR" "Backup creation failed"
        exit 1
    fi
}

# Error handler
trap 'log "ERROR" "Script interrupted"; exit 1' INT TERM

main "$@"
```

**Assignment:**
1. Run this script with your own directory
2. Verify the backup was created
3. Test backup rotation by modifying RETENTION_DAYS
4. Extend the script to send email reports on failure

**Interview Questions (Week 1-2 Summary):**
1. Explain the difference between `$?` and `$#`
2. How would you handle errors in a bash script safely?
3. Create a function that validates if a port is open
4. Write a loop that processes files but skips hidden files
5. Explain parameter expansion `${var:-default}`

---

## 🎯 WEEK 3: ADVANCED TEXT PROCESSING (Days 11-15)

### Day 11: grep, Regex & Pattern Matching
**Topics:** grep patterns, regular expressions, matching strategies

**Key Concepts:**
```bash
# Basic grep
grep "pattern" file.txt         # Search for pattern
grep -i "pattern" file.txt      # Case-insensitive
grep -v "pattern" file.txt      # Invert (show non-matching)
grep -c "pattern" file.txt      # Count matches
grep -n "pattern" file.txt      # Show line numbers
grep -l "pattern" *.txt         # Show filenames only
grep -A 3 "pattern" file.txt    # Show 3 lines after match
grep -B 2 "pattern" file.txt    # Show 2 lines before match
grep -C 2 "pattern" file.txt    # Show 2 lines around match

# Regular expressions with grep -E (extended)
grep -E "^error" file.txt       # Start with "error"
grep -E "^error|^warn" file.txt # Multiple patterns (OR)
grep -E "[0-9]+" file.txt       # One or more digits
grep -E "[a-zA-Z_]" file.txt    # Character classes

# Regex patterns
^       # Start of line
$       # End of line
.       # Any single character
*       # Zero or more of previous
+       # One or more of previous (extended)
?       # Zero or one of previous (extended)
[...]   # Character class
[^...]  # Negated character class
()      # Grouping (extended)
|       # OR (extended)
\       # Escape special character
```

**Exercise: Log analysis with grep**
```bash
#!/bin/bash
logfile="${1:-/var/log/syslog}"

if [ ! -f "$logfile" ]; then
    echo "ERROR: Log file not found"
    exit 1
fi

echo "=== Log Analysis Report ==="
echo "File: $logfile"
echo ""

echo "Total log entries:"
wc -l "$logfile" | awk '{print $1}'
echo ""

echo "Error entries:"
grep -c -i "error" "$logfile" || echo "0"
echo ""

echo "Warning entries:"
grep -c -i "warn" "$logfile" || echo "0"
echo ""

echo "Recent errors (last 5):"
grep -i "error" "$logfile" | tail -5
echo ""

echo "Connection timeout errors:"
grep -i "timeout" "$logfile" | grep -i "connection"
echo ""

echo "Failed authentication attempts:"
grep -i "failed" "$logfile" | grep -i "auth"
```

---

### Day 12: sed - Stream Editor
**Topics:** sed basics, substitution, deletion, transformation

**Key Concepts:**
```bash
# Basic sed substitution
sed 's/old/new/' file.txt           # Replace first occurrence per line
sed 's/old/new/g' file.txt          # Replace all occurrences (g = global)
sed 's/old/new/2' file.txt          # Replace 2nd occurrence
sed 's/old/new/gi' file.txt         # Case-insensitive replacement

# Deletion
sed '/pattern/d' file.txt           # Delete lines matching pattern
sed '5d' file.txt                   # Delete line 5
sed '1,3d' file.txt                 # Delete lines 1-3
sed '$d' file.txt                   # Delete last line

# Insertion and append
sed '/pattern/a Text to append' file.txt    # Append after pattern
sed '/pattern/i Text to insert' file.txt    # Insert before pattern
sed '/pattern/c Replacement text' file.txt  # Change/replace line

# Advanced
sed -e 's/foo/bar/' -e 's/hello/world/' file.txt  # Multiple operations
sed 's#/#_#g' file.txt              # Using # as delimiter
sed -n '/pattern/p' file.txt        # Print only lines matching
sed '1,5s/old/new/' file.txt        # Replace in range 1-5

# In-place editing
sed -i 's/old/new/g' file.txt       # Modify file directly
sed -i.bak 's/old/new/g' file.txt   # Create backup before modifying
```

**Exercise: Configuration file updater**
```bash
#!/bin/bash
config_file="${1:-/etc/myapp/config.conf}"

if [ ! -f "$config_file" ]; then
    echo "ERROR: Config file not found"
    exit 1
fi

echo "Updating configuration..."

# Update database host
sed -i.bak 's/^db_host=.*/db_host=localhost/' "$config_file"

# Update port (with validation)
sed -i 's/^port=.*/port=8080/' "$config_file"

# Comment out debug mode
sed -i 's/^debug=true/# debug=true/' "$config_file"

# Add new config if it doesn't exist
if ! grep -q "^log_level=" "$config_file"; then
    sed -i '$ a log_level=INFO' "$config_file"
fi

# Display changes
echo "Configuration updated. Changes:"
diff "$config_file".bak "$config_file" || true

# Verify
if [ -f "$config_file" ]; then
    echo "Config file successfully updated"
else
    echo "ERROR: Update failed"
    mv "$config_file".bak "$config_file"
    exit 1
fi
```

---

### Day 13: awk - Text Processing
**Topics:** awk basics, fields, patterns, actions, built-in variables

**Key Concepts:**
```bash
# awk basic syntax: awk 'pattern { action }' file

# Field access
awk '{print $1}' file.txt              # Print first field
awk '{print $1, $3}' file.txt          # Print fields 1 and 3
awk '{print $NF}' file.txt             # Print last field
awk -F: '{print $1}' /etc/passwd       # Change field separator

# Built-in variables
NF      # Number of fields
NR      # Number of records (lines)
FS      # Field separator (default: space)
OFS     # Output field separator
$0      # Entire line
$1-$NF  # Individual fields

# Patterns and actions
awk '/pattern/ {print}' file.txt       # Print lines matching pattern
awk 'NR==5 {print}' file.txt           # Print line 5
awk 'NR > 5 {print}' file.txt          # Print lines after 5
awk '$3 > 100 {print}' file.txt        # Print if 3rd field > 100

# Arithmetic and comparisons
awk '{sum += $1} END {print sum}' file.txt  # Sum first field
awk '{if ($3 > 100) print $1}' file.txt    # Conditional
awk '{print $1, $2 * 2}' file.txt          # Multiply field

# String operations
awk '{print length($0)}' file.txt      # Length of line
awk '{print toupper($1)}' file.txt     # Uppercase
awk '{print tolower($1)}' file.txt     # Lowercase
awk '{gsub(/old/, "new"); print}' file.txt  # Global substitution
```

**Exercise: System resource monitor**
```bash
#!/bin/bash

echo "=== System Resource Usage ==="
echo ""

echo "Disk Usage by Partition:"
df -h | awk 'NR>1 {printf "%-20s %10s %10s %10s (%s)\n", $1, $2, $3, $4, $5}'
echo ""

echo "Top 5 largest files/directories:"
du -sh * 2>/dev/null | sort -rh | head -5 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""

echo "Memory Usage Details:"
free -h | awk 'NR==2 {
    total=$2
    used=$3
    free=$4
    printf "Total: %s\nUsed:  %s\nFree:  %s\n", total, used, free
}'
echo ""

echo "CPU Load Average:"
uptime | awk -F'load average:' '{print $2}' | awk '{
    printf "1min: %s, 5min: %s, 15min: %s\n", $1, $2, $3
}'
echo ""

echo "Top 5 processes by memory:"
ps aux | awk 'NR>1 {print $6, $11}' | sort -rn | head -5 | awk '{
    printf "%s KB - %s\n", $1, $2
}'
```

---

### Day 14: Advanced Text Processing - Combining Tools
**Topics:** Piping, multi-tool workflows, text transformation chains

**Exercise: Log aggregation and analysis**
```bash
#!/bin/bash

logfile="${1:-/var/log/access.log}"
analysis_date="$(date +%Y-%m-%d)"

if [ ! -f "$logfile" ]; then
    echo "ERROR: Log file not found"
    exit 1
fi

echo "=== Log Analysis Report for $analysis_date ==="
echo ""

# Unique IPs with request count
echo "Top 10 IP Addresses by Request Count:"
grep "$analysis_date" "$logfile" | awk '{print $1}' | sort | uniq -c | sort -rn | head -10
echo ""

# Status code distribution
echo "HTTP Status Code Distribution:"
grep "$analysis_date" "$logfile" | awk '{print $9}' | sort | uniq -c | sort -rn
echo ""

# Response time analysis
echo "Average Response Time (by path):"
grep "$analysis_date" "$logfile" | awk '{
    path=$7
    time=$(NF-1)
    sum[path] += time
    count[path]++
}
END {
    for (p in sum) {
        avg = sum[p] / count[p]
        printf "%s: %.2f ms\n", p, avg
    }
}' | sort -t: -k2 -rn | head -10
echo ""

# Slowest requests
echo "Slowest Requests:"
grep "$analysis_date" "$logfile" | awk '{
    time=$(NF-1)
    path=$7
    print time, path
}' | sort -rn | head -5 | awk '{printf "%.2f ms - %s\n", $1, $2}'
echo ""

# Error analysis
echo "HTTP Errors (4xx and 5xx):"
grep "$analysis_date" "$logfile" | awk '$9 >= 400 {print $1, $9, $7}' | sort | uniq -c | sort -rn | head -10
```

---

### Day 15: Week 3 Project - Log Parser and Alerter
**Topics:** Integration of grep, sed, awk for real-world DevOps task

```bash
#!/bin/bash

# =============================================================================
# Intelligent Log Parser and Alert System
# Monitors logs and generates alerts for critical issues
# =============================================================================

set -euo pipefail

# Configuration
readonly LOG_FILE="${LOG_FILE:-/var/log/syslog}"
readonly ALERT_THRESHOLD_ERROR=10
readonly ALERT_THRESHOLD_WARN=20
readonly OUTPUT_DIR="${OUTPUT_DIR:-.}"
readonly REPORT_FILE="$OUTPUT_DIR/log_report_$(date +%Y%m%d_%H%M%S).txt"

# Initialize report
init_report() {
    {
        echo "======================================"
        echo "Log Analysis Report"
        echo "Generated: $(date)"
        echo "Source: $LOG_FILE"
        echo "======================================"
        echo ""
    } > "$REPORT_FILE"
}

# Check for errors
analyze_errors() {
    echo "Analyzing errors..." >&2
    {
        echo "=== ERROR ANALYSIS ==="
        echo ""
        echo "Total error entries:"
        grep -i "error\|critical\|fatal" "$LOG_FILE" | wc -l
        echo ""
        echo "Errors by type:"
        grep -i "error\|critical\|fatal" "$LOG_FILE" | \
            sed 's/.*\(error\|critical\|fatal\).*/\1/I' | \
            sort | uniq -c | sort -rn
        echo ""
    } >> "$REPORT_FILE"
}

# Check for warnings
analyze_warnings() {
    echo "Analyzing warnings..." >&2
    {
        echo "=== WARNING ANALYSIS ==="
        echo ""
        echo "Total warning entries:"
        grep -i "warn" "$LOG_FILE" | wc -l
        echo ""
        echo "Warnings by type:"
        grep -i "warn" "$LOG_FILE" | \
            awk '{
                for (i=1; i<=NF; i++) {
                    if ($i ~ /^[a-z_]+warning/i) {
                        print $i
                    }
                }
            }' | sort | uniq -c | sort -rn | head -10
        echo ""
    } >> "$REPORT_FILE"
}

# Extract key metrics
extract_metrics() {
    echo "Extracting metrics..." >&2
    {
        echo "=== KEY METRICS ==="
        echo ""
        echo "Total log entries: $(wc -l < $LOG_FILE)"
        echo "Date range: $(head -1 $LOG_FILE) to $(tail -1 $LOG_FILE)"
        echo ""
        
        # Most common log entries
        echo "Most common log messages:"
        tail -1000 "$LOG_FILE" | \
            sed 's/^[^:]*: //' | \
            sort | uniq -c | sort -rn | head -5 | \
            awk '{$1=$1; print "  Count: " $1 " - " substr($0, index($0,$2))}'
        echo ""
    } >> "$REPORT_FILE"
}

# Generate alerts
generate_alerts() {
    echo "Checking alert thresholds..." >&2
    {
        echo "=== ALERT SUMMARY ==="
        echo ""
        
        error_count=$(grep -i "error\|critical\|fatal" "$LOG_FILE" | wc -l || echo 0)
        warn_count=$(grep -i "warn" "$LOG_FILE" | wc -l || echo 0)
        
        if [ "$error_count" -ge "$ALERT_THRESHOLD_ERROR" ]; then
            echo "🚨 CRITICAL ALERT: High error count detected ($error_count >= $ALERT_THRESHOLD_ERROR)"
        else
            echo "✓ Error count normal: $error_count"
        fi
        
        if [ "$warn_count" -ge "$ALERT_THRESHOLD_WARN" ]; then
            echo "⚠️  WARNING ALERT: High warning count ($warn_count >= $ALERT_THRESHOLD_WARN)"
        else
            echo "✓ Warning count normal: $warn_count"
        fi
        echo ""
    } >> "$REPORT_FILE"
}

# Main execution
main() {
    if [ ! -f "$LOG_FILE" ]; then
        echo "ERROR: Log file not found: $LOG_FILE"
        exit 1
    fi
    
    echo "Starting log analysis..."
    init_report
    analyze_errors
    analyze_warnings
    extract_metrics
    generate_alerts
    
    echo ""
    echo "Report generated: $REPORT_FILE"
    cat "$REPORT_FILE"
}

main "$@"
```

**Interview Questions (Week 3):**
1. How would you extract all IP addresses from a log file?
2. Explain the difference between `grep -E` and `grep -P`
3. Write a sed command to remove all empty lines from a file
4. How do you use awk to calculate statistics from numeric fields?
5. What's the most efficient way to count occurrences of a pattern in a large file?

---

## 🎯 WEEK 4: DEVOPS AUTOMATION SCENARIOS (Days 16-20)

### Day 16: Deployment Automation
**Topics:** Application deployment, version control, rollback strategies

```bash
#!/bin/bash

# =============================================================================
# Production Deployment Script
# Handles application deployment with safety checks and rollback
# =============================================================================

set -euo pipefail

# Configuration
readonly APP_NAME="myapp"
readonly REPO_URL="https://github.com/org/myapp.git"
readonly APP_PATH="/opt/myapp"
readonly BACKUP_PATH="/backups/myapp"
readonly DEPLOY_LOG="/var/log/deploy.log"
readonly NOTIFICATION_EMAIL="devops@example.com"

# Logging
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$DEPLOY_LOG"
}

# Validation
validate_deployment() {
    log "INFO" "Validating deployment prerequisites..."
    
    # Check if user is root or has sudo
    if [ "$EUID" -ne 0 ]; then
        log "ERROR" "Must run as root or with sudo"
        return 1
    fi
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        log "ERROR" "git is not installed"
        return 1
    fi
    
    # Check disk space
    local available=$(df "$APP_PATH" 2>/dev/null | awk 'NR==2 {print $4}')
    if [ "$available" -lt 1000000 ]; then  # Less than 1GB
        log "WARNING" "Low disk space available: $available KB"
    fi
    
    log "INFO" "Validation passed"
    return 0
}

# Backup current version
backup_current() {
    log "INFO" "Backing up current version..."
    
    if [ ! -d "$APP_PATH" ]; then
        log "WARN" "Application not found, skipping backup"
        return 0
    fi
    
    mkdir -p "$BACKUP_PATH"
    local backup_file="$BACKUP_PATH/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    if tar -czf "$backup_file" -C "$APP_PATH" .; then
        log "INFO" "Backup created: $backup_file"
        echo "$backup_file"
        return 0
    else
        log "ERROR" "Backup failed"
        return 1
    fi
}

# Pull latest code
pull_code() {
    log "INFO" "Pulling latest code..."
    
    if [ ! -d "$APP_PATH/.git" ]; then
        log "INFO" "Cloning repository..."
        mkdir -p "$APP_PATH"
        git clone "$REPO_URL" "$APP_PATH"
    else
        log "INFO" "Updating existing repository..."
        cd "$APP_PATH"
        git fetch origin
        git reset --hard origin/main
    fi
    
    log "INFO" "Code pull completed"
}

# Run tests
run_tests() {
    log "INFO" "Running tests..."
    
    cd "$APP_PATH"
    
    if [ -f "Makefile" ] && grep -q "^test:" Makefile; then
        if make test; then
            log "INFO" "Tests passed"
            return 0
        else
            log "ERROR" "Tests failed"
            return 1
        fi
    elif [ -f "pytest.ini" ]; then
        if pytest -v; then
            log "INFO" "Tests passed"
            return 0
        else
            log "ERROR" "Tests failed"
            return 1
        fi
    else
        log "WARN" "No test configuration found, skipping tests"
        return 0
    fi
}

# Deploy application
deploy() {
    log "INFO" "Starting deployment..."
    
    cd "$APP_PATH"
    
    # Stop service
    log "INFO" "Stopping application..."
    if systemctl is-active --quiet "$APP_NAME"; then
        systemctl stop "$APP_NAME" || {
            log "ERROR" "Failed to stop service"
            return 1
        }
    fi
    
    # Install dependencies
    log "INFO" "Installing dependencies..."
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt || {
            log "ERROR" "Dependency installation failed"
            return 1
        }
    fi
    
    # Run migrations (if applicable)
    if [ -f "manage.py" ]; then
        log "INFO" "Running database migrations..."
        python manage.py migrate || {
            log "ERROR" "Migration failed"
            return 1
        }
    fi
    
    # Start service
    log "INFO" "Starting application..."
    if ! systemctl start "$APP_NAME"; then
        log "ERROR" "Failed to start service"
        return 1
    fi
    
    # Health check
    sleep 5
    if curl -sf "http://localhost:8080/health" > /dev/null; then
        log "INFO" "Health check passed"
        return 0
    else
        log "ERROR" "Health check failed"
        return 1
    fi
}

# Rollback to previous version
rollback() {
    log "ERROR" "Deployment failed, rolling back..."
    
    # Find latest backup
    local latest_backup=$(ls -t "$BACKUP_PATH"/backup_*.tar.gz | head -1)
    
    if [ -z "$latest_backup" ]; then
        log "CRITICAL" "No backup found for rollback"
        return 1
    fi
    
    # Stop current version
    systemctl stop "$APP_NAME" || true
    
    # Restore backup
    rm -rf "$APP_PATH"
    mkdir -p "$APP_PATH"
    tar -xzf "$latest_backup" -C "$APP_PATH"
    
    # Restart service
    systemctl start "$APP_NAME"
    
    log "INFO" "Rollback completed"
}

# Send notification
send_notification() {
    local status=$1
    local message=$2
    
    if [ -z "${NOTIFICATION_EMAIL:-}" ]; then
        return 0
    fi
    
    # Implementation depends on your notification system
    # Example: sendmail, webhook, Slack, etc.
    log "INFO" "Notification sent: $status - $message"
}

# Main
main() {
    log "INFO" "====== Deployment Start ======"
    
    local backup_file=""
    
    if ! validate_deployment; then
        log "ERROR" "Validation failed"
        exit 1
    fi
    
    if ! backup_file=$(backup_current); then
        log "ERROR" "Backup failed"
        exit 1
    fi
    
    if ! pull_code; then
        log "ERROR" "Code pull failed"
        exit 1
    fi
    
    if ! run_tests; then
        log "ERROR" "Tests failed"
        exit 1
    fi
    
    if ! deploy; then
        log "ERROR" "Deployment failed, initiating rollback"
        if rollback; then
            send_notification "DEPLOYMENT_FAILED" "Deployment failed but rollback successful"
        else
            send_notification "CRITICAL" "Deployment failed and rollback failed"
        fi
        exit 1
    fi
    
    log "INFO" "Deployment completed successfully"
    send_notification "SUCCESS" "Application deployed successfully"
    log "INFO" "====== Deployment End ======"
}

trap 'log "ERROR" "Script interrupted"; exit 1' INT TERM
main "$@"
```

---

### Day 17: Container Management & Docker
**Topics:** Docker operations, container orchestration, health monitoring

```bash
#!/bin/bash

# =============================================================================
# Docker Container Management Script
# =============================================================================

set -euo pipefail

# Configuration
readonly REGISTRY="registry.example.com"
readonly IMAGE_NAME="myapp"
readonly CONTAINER_NAME="myapp-container"
readonly PORT_MAPPING="8080:8080"
readonly VOLUME_MOUNT="/data:/app/data"

# Check Docker installation
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "ERROR: Docker is not installed"
        return 1
    fi
    
    if ! docker ps &> /dev/null; then
        echo "ERROR: Cannot connect to Docker daemon"
        return 1
    fi
    
    return 0
}

# Build Docker image
build_image() {
    local version=$1
    local image_tag="$REGISTRY/$IMAGE_NAME:$version"
    
    echo "Building Docker image: $image_tag"
    
    if docker build -t "$image_tag" \
        --build-arg VERSION="$version" \
        --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
        -f Dockerfile .; then
        echo "✓ Image built successfully"
        return 0
    else
        echo "✗ Image build failed"
        return 1
    fi
}

# Push image to registry
push_image() {
    local version=$1
    local image_tag="$REGISTRY/$IMAGE_NAME:$version"
    
    echo "Pushing image to registry: $image_tag"
    
    if docker push "$image_tag"; then
        echo "✓ Image pushed successfully"
        return 0
    else
        echo "✗ Image push failed"
        return 1
    fi
}

# Run container
run_container() {
    local version=$1
    local image_tag="$REGISTRY/$IMAGE_NAME:$version"
    
    echo "Starting container from image: $image_tag"
    
    # Stop existing container if running
    if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Stopping existing container..."
        docker stop "$CONTAINER_NAME" || true
        docker rm "$CONTAINER_NAME" || true
    fi
    
    # Run new container
    if docker run -d \
        --name "$CONTAINER_NAME" \
        -p "$PORT_MAPPING" \
        -v "$VOLUME_MOUNT" \
        --restart unless-stopped \
        --health-cmd='curl -f http://localhost:8080/health || exit 1' \
        --health-interval=30s \
        --health-timeout=10s \
        --health-retries=3 \
        --health-start-period=40s \
        "$image_tag"; then
        echo "✓ Container started successfully"
        echo "Container ID: $(docker ps -q -f name=$CONTAINER_NAME)"
        return 0
    else
        echo "✗ Failed to start container"
        return 1
    fi
}

# Check container health
check_health() {
    local max_attempts=30
    local attempt=0
    
    echo "Checking container health..."
    
    while [ $attempt -lt $max_attempts ]; do
        local health=$(docker inspect "$CONTAINER_NAME" --format='{{.State.Health.Status}}' 2>/dev/null)
        
        case "$health" in
            healthy)
                echo "✓ Container is healthy"
                return 0
                ;;
            unhealthy)
                echo "✗ Container is unhealthy"
                docker logs "$CONTAINER_NAME" | tail -20
                return 1
                ;;
            starting)
                echo "Container is starting... ($((attempt + 1))/$max_attempts)"
                sleep 1
                attempt=$((attempt + 1))
                ;;
            *)
                echo "Container health status unknown: $health"
                return 1
                ;;
        esac
    done
    
    echo "✗ Container health check timeout"
    return 1
}

# View logs
view_logs() {
    local lines="${1:-50}"
    echo "Last $lines lines of container logs:"
    docker logs --tail "$lines" -f "$CONTAINER_NAME"
}

# Get container statistics
get_stats() {
    echo "Container resource usage:"
    docker stats "$CONTAINER_NAME" --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"
}

# Clean up
cleanup() {
    echo "Cleaning up Docker resources..."
    
    # Remove stopped containers
    docker container prune -f
    
    # Remove dangling images
    docker image prune -f
    
    # Remove dangling volumes
    docker volume prune -f
    
    echo "✓ Cleanup completed"
}

# Main
main() {
    local command="${1:-help}"
    shift || true
    
    if ! check_docker; then
        exit 1
    fi
    
    case "$command" in
        build)
            build_image "${1:-latest}"
            ;;
        push)
            push_image "${1:-latest}"
            ;;
        run)
            run_container "${1:-latest}"
            ;;
        health)
            check_health
            ;;
        logs)
            view_logs "${1:-50}"
            ;;
        stats)
            get_stats
            ;;
        cleanup)
            cleanup
            ;;
        *)
            echo "Usage: $0 {build|push|run|health|logs|stats|cleanup} [args]"
            exit 1
            ;;
    esac
}

main "$@"
```

---

### Days 18-20: More DevOps Scenarios

[Due to length constraints, I'll provide a summary of remaining days]

**Day 18: Kubernetes Operations** - Deployment, scaling, monitoring
**Day 19: Monitoring & Alerting** - Metrics collection, alert rules
**Day 20: CI/CD Pipeline Integration** - Jenkins/GitLab integration

---

## 🎯 WEEK 5: INTERVIEW PREPARATION & PROJECTS (Days 21-35)

### Days 21-25: Real-World DevOps Projects

**Project 1: Infrastructure Monitoring Dashboard**
- CPU, memory, disk usage tracking
- Log aggregation
- Alert triggering

**Project 2: Automated Backup & Recovery**
- Multi-source backups
- Retention policies
- Recovery testing

**Project 3: CI/CD Pipeline**
- Automated build, test, deploy
- Rollback mechanisms
- Notification system

### Days 26-30: Interview Question Deep Dives

**Common DevOps Interview Questions:**

1. **Explain a complex bash script you've written**
   - What was the purpose?
   - What challenges did you face?
   - How did you optimize it?

2. **How would you debug a failing bash script?**
   - Use `set -x` for tracing
   - Check exit codes with `$?`
   - Use `bash -n` for syntax checking

3. **Write a script to monitor disk usage and alert**
   ```bash
   # Pseudo-code outline
   threshold=80
   for partition in $(df | awk 'NR>1 {print $6}'); do
       usage=$(df $partition | awk 'NR==2 {print $5}' | cut -d% -f1)
       if [ $usage -gt $threshold ]; then
           # Send alert
       fi
   done
   ```

4. **How do you handle sensitive data in scripts?**
   - Use environment variables
   - Don't hardcode credentials
   - Restrict file permissions (chmod 600)
   - Use secret management tools

5. **Explain error handling strategies**
   - Use `set -e` for exit on error
   - Use `set -u` for undefined variables
   - Use `set -o pipefail` for pipe errors
   - Use `trap` for cleanup

### Days 31-35: Mock Interviews & Final Projects

**Mock Interview Script:**
```bash
#!/bin/bash
# Run through these scenarios in 1 hour

# Scenario 1: Deploy an application
# Scenario 2: Debug a failing service
# Scenario 3: Optimize slow script
# Scenario 4: Handle edge cases
# Scenario 5: Design monitoring solution
```

---

## 📊 Daily Learning Schedule (1-2 hours)

| Time | Activity | Duration |
|------|----------|----------|
| 0:00-0:15 | Review concepts | 15 min |
| 0:15-0:50 | Follow tutorial | 35 min |
| 0:50-1:20 | Practice exercises | 30 min |
| 1:20-1:50 | Interview Q&A or projects | 30 min |
| 1:50-2:00 | Review & notes | 10 min |

---

## 🎯 Success Checklist

By the end of 35 days, you should be able to:

- [ ] Write robust bash scripts with error handling
- [ ] Use grep, sed, awk for log analysis
- [ ] Automate deployments safely
- [ ] Manage Docker containers
- [ ] Monitor systems with bash
- [ ] Debug scripts effectively
- [ ] Answer DevOps interview questions confidently
- [ ] Build complete automation solutions

---

## 📚 Recommended Resources

- **Official:** GNU Bash Manual, man pages
- **Practice:** HackerRank, CodeWars (bash challenges)
- **Books:** "Pro Bash Programming" by Carl Albing
- **Documentation:** DevOps platform docs (AWS, K8s, Docker)

---

## 🔗 Next Steps

1. **Day 1-5:** Master fundamentals
2. **Day 6-10:** Practice control structures
3. **Day 11-20:** Build text processing skills
4. **Day 21-30:** Apply to real DevOps scenarios
5. **Day 31-35:** Interview preparation

Good luck! You'll be DevOps-ready in 35 days! 🚀

