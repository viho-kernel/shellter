# 🚀 DAY 1 QUICK START - Your First 90 Minutes

**Goal:** Setup your environment and write your first bash scripts  
**Time:** 90 minutes  
**Outcome:** Understand shebang, variables, and execute your first scripts  

---

## ⏱️ Timeline (90 min total)

| Time | Activity | Duration |
|------|----------|----------|
| 0:00-0:10 | Setup & Environment | 10 min |
| 0:10-0:25 | Understand Concepts | 15 min |
| 0:25-0:55 | Write & Test Scripts | 30 min |
| 0:55-1:20 | Practice Exercises | 25 min |
| 1:20-1:30 | Review & Next Steps | 10 min |

---

## 🔧 STEP 1: Setup Your Environment (10 min)

### 1.1 Create Learning Directory
```bash
# Open terminal and run:
mkdir -p ~/bash-learning
cd ~/bash-learning

# Create subdirectories for organization
mkdir -p day{1..35}
mkdir -p projects
mkdir -p practice

# Verify structure
ls -la
```

### 1.2 Check Your Bash Version
```bash
bash --version
# Should be 4.0 or higher

# Also check your shell
echo $SHELL
# Should output: /bin/bash
```

### 1.3 Create a Test Directory
```bash
mkdir -p ~/bash-learning/day1/test_data
cd ~/bash-learning/day1

# Create some test files
echo "This is a test file" > test.txt
echo "user1:500" > data.txt
echo "user2:600" >> data.txt
```

**✓ Setup Complete!**

---

## 📚 STEP 2: Understand Key Concepts (15 min)

### 2.1 What is a Bash Script?
A bash script is a text file containing a sequence of bash commands. It automates tasks that would otherwise be typed manually.

### 2.2 The Shebang (#!)
```bash
#!/bin/bash
```

**Why it matters:**
- First line tells the system to use bash interpreter
- Without it, you must run: `bash script.sh`
- With it, you can run: `./script.sh`

**Analogy:** Like a label on a box telling the postal service how to handle it.

### 2.3 Making Scripts Executable
```bash
chmod +x script.sh   # Add execute permission
chmod 755 script.sh  # Owner: full, Others: read+execute
chmod 600 script.sh  # Owner: full, Others: nothing (secure)

# Check permissions
ls -l script.sh
# Example output: -rwxr-xr-x (executable)
```

**Permission breakdown:**
- First `-` = regular file (d = directory, l = link)
- Next 3 chars `rwx` = owner permissions (read, write, execute)
- Next 3 chars `r-x` = group permissions
- Last 3 chars `r-x` = others permissions

### 2.4 Environment Variables
```bash
# Global variables available to all programs
PATH       # Where system looks for commands
HOME       # Your home directory
USER       # Your username
SHELL      # Your shell program
PWD        # Current working directory
$?         # Exit code of last command (0=success, 1+=error)
```

**Try it:**
```bash
echo $PATH        # See all directories searched for commands
echo $HOME        # Your home path
echo $USER        # Your username
echo $PWD         # Current directory
```

---

## 💻 STEP 3: Write Your First Scripts (30 min)

### Script 1: Hello World (Your First Script)

**Step 1:** Create the file
```bash
cd ~/bash-learning/day1
nano hello.sh
```

**Step 2:** Type this (exactly):
```bash
#!/bin/bash
echo "Hello, DevOps World!"
echo "I'm learning Bash scripting!"
```

**Step 3:** Save and exit
- Press `Ctrl+O` (Save)
- Press `Enter` (Confirm)
- Press `Ctrl+X` (Exit)

**Step 4:** Make it executable
```bash
chmod +x hello.sh
```

**Step 5:** Run it
```bash
./hello.sh
# Output:
# Hello, DevOps World!
# I'm learning Bash scripting!
```

**✓ Congratulations! You wrote your first bash script!**

---

### Script 2: Environment Information

**Create file:** `nano system_info.sh`

```bash
#!/bin/bash

# This is a comment - it explains what the script does
# Display system and user information

echo "=== Your System Information ==="
echo ""

echo "User Information:"
echo "  Username: $USER"
echo "  Home Directory: $HOME"
echo "  Shell: $SHELL"
echo ""

echo "System Information:"
echo "  Current Directory: $PWD"
echo "  Hostname: $(hostname)"
echo "  Current Date: $(date)"
echo ""

echo "System Resources:"
echo "  Kernel: $(uname -s)"
echo "  Kernel Version: $(uname -r)"
```

**Run it:**
```bash
chmod +x system_info.sh
./system_info.sh
```

**What you learned:**
- `#` = Comments
- `$(command)` = Command substitution (runs command, uses output)
- `$VARIABLE` = Variable expansion
- `echo` = Print output

---

### Script 3: Interactive Input

**Create file:** `nano greeting.sh`

```bash
#!/bin/bash

# This script asks for your name and greets you

echo "What is your name?"
read name

echo ""
echo "Hello, $name! Welcome to bash scripting!"
echo "Today is $(date '+%A, %B %d, %Y')"
echo "Your home directory is: $HOME"
```

**Run it:**
```bash
chmod +x greeting.sh
./greeting.sh
# When it asks: type your name and press Enter
```

**What you learned:**
- `read` = Get user input
- Variable `$name` = Stores user input
- Date formatting with `date '+%A, %B %d, %Y'`

---

## 🎯 STEP 4: Practice Exercises (25 min)

### Exercise 1: Create a Math Calculator Script

**Goal:** Use arithmetic in bash

**Create:** `nano calculator.sh`

```bash
#!/bin/bash

echo "=== Simple Calculator ==="
echo ""

# Ask user for two numbers
echo "Enter first number:"
read num1

echo "Enter second number:"
read num2

# Perform calculations
sum=$((num1 + num2))
diff=$((num1 - num2))
product=$((num1 * num2))

# Display results
echo ""
echo "Results:"
echo "  $num1 + $num2 = $sum"
echo "  $num1 - $num2 = $diff"
echo "  $num1 × $num2 = $product"

# Integer division
quotient=$((num1 / num2))
echo "  $num1 ÷ $num2 = $quotient (integer division)"
```

**Test it:**
```bash
chmod +x calculator.sh
./calculator.sh
# Try: 10 and 3
# Expected output:
#   10 + 3 = 13
#   10 - 3 = 7
#   10 × 3 = 30
#   10 ÷ 3 = 3
```

**Interview Question:** *Why do we use $(( )) for arithmetic instead of $( )*
> $(( )) is for arithmetic expansion, while $( ) is for command substitution. Using the right one is clearer and more efficient.

---

### Exercise 2: List Files with Details

**Goal:** Use loops and command output

**Create:** `nano list_files.sh`

```bash
#!/bin/bash

echo "=== Files in Current Directory ==="
echo ""

# Count files
count=0

# Loop through files
for file in *; do
    if [ -f "$file" ]; then  # Check if it's a file (not directory)
        size=$(du -h "$file" | awk '{print $1}')
        count=$((count + 1))
        echo "$count. $file (Size: $size)"
    fi
done

echo ""
echo "Total files: $count"
```

**Test it:**
```bash
chmod +x list_files.sh
./list_files.sh
# Should list all files in current directory with sizes
```

---

### Exercise 3: File Checker Script

**Goal:** Use conditional logic and file testing

**Create:** `nano file_checker.sh`

```bash
#!/bin/bash

# Ask user for filename
echo "Enter a filename to check:"
read filename

echo ""

# Check if file exists
if [ -f "$filename" ]; then
    echo "✓ File exists!"
    
    # Check if readable
    if [ -r "$filename" ]; then
        echo "✓ File is readable"
    else
        echo "✗ File is NOT readable"
    fi
    
    # Check if writable
    if [ -w "$filename" ]; then
        echo "✓ File is writable"
    else
        echo "✗ File is NOT writable"
    fi
    
    # Check if executable
    if [ -x "$filename" ]; then
        echo "✓ File is executable"
    else
        echo "✗ File is NOT executable"
    fi
    
    # Show file size
    size=$(wc -c < "$filename")
    echo "File size: $size bytes"
    
else
    echo "✗ File does not exist!"
fi
```

**Test it:**
```bash
chmod +x file_checker.sh
./file_checker.sh
# Enter: test.txt
```

---

## 📋 STEP 5: Verify Your Learning (10 min)

### Checklist

- [ ] Created learning directory: `~/bash-learning`
- [ ] Understand shebang (#!) and its purpose
- [ ] Know how to use `chmod +x` to make scripts executable
- [ ] Can run scripts with `./script.sh`
- [ ] Understand `$VARIABLE` syntax
- [ ] Can use `read` to get user input
- [ ] Can perform arithmetic with `$(( ))`
- [ ] Can use `echo` with variables
- [ ] Created and ran 3+ scripts today
- [ ] Exercises 1-3 all completed

---

## 🎓 Key Takeaways From Day 1

| Concept | How to Use | Example |
|---------|-----------|---------|
| **Shebang** | First line, tells system which interpreter | `#!/bin/bash` |
| **chmod** | Make script executable | `chmod +x script.sh` |
| **Variables** | Store data with `$` prefix | `echo $USER` |
| **Arithmetic** | Use $(( )) for math | `sum=$((5+3))` |
| **read** | Get user input | `read name` |
| **echo** | Print output | `echo "Hello $name"` |
| **Comments** | Explain code with # | `# This is a comment` |

---

## 🔍 Interview Questions (Day 1)

### Q1: What is the shebang and why is it important?
**Good Answer:**
> The shebang (#!) is the first line of a script that tells the operating system which interpreter to use. For bash scripts, it's `#!/bin/bash`. It's important because it allows you to run the script directly with `./script.sh` without explicitly calling `bash script.sh`. Without it, you need to use the bash interpreter explicitly.

### Q2: Explain the difference between `./script.sh` and `bash script.sh`
**Good Answer:**
> - `./script.sh` runs the script using the interpreter specified in the shebang. The file must be executable (chmod +x).
> - `bash script.sh` explicitly calls the bash interpreter to run the script, doesn't require shebang or executable permission.
> Both work, but `./script.sh` is preferred in production because it's more portable.

### Q3: What does `chmod +x` do?
**Good Answer:**
> `chmod +x` adds execute permission to a file for the owner, allowing it to be run as a program. Without this, trying to run `./script.sh` will give a "Permission denied" error. The `x` stands for execute permission.

### Q4: How do you capture command output in a script?
**Good Answer:**
> Use command substitution with `$(command)` or backticks `` `command` ``. For example:
> ```bash
> current_date=$(date)
> echo "Today is: $current_date"
> ```
> The `$( )` syntax is preferred as it's more readable and handles nested commands better.

### Q5: What's the difference between `$variable` and `${variable}`?
**Good Answer:**
> Both expand the variable, but `${variable}` is safer in contexts where ambiguity might arise:
> ```bash
> # Problematic: Bash doesn't know where $name ends
> echo "Hello $namesuffix"
> 
> # Clear: Bash knows variable name
> echo "Hello ${name}suffix"
> ```
> Use `${variable}` when the variable is adjacent to text with no space.

---

## 🚀 Tomorrow (Day 2)

**Prepare for:** Variables, Data Types & Operators

**To-Do Before Day 2:**
- [ ] Review all scripts from Day 1
- [ ] Try modifying one script (e.g., change the greeting)
- [ ] Run `./hello.sh` 5 times to build confidence
- [ ] Note any errors you encountered
- [ ] Read about arithmetic operators: `+`, `-`, `*`, `/`, `%`

**Quick preview of Day 2:**
```bash
# You'll learn to do this:
num1=10
num2=5
result=$((num1 + num2))
echo "Sum: $result"  # Output: Sum: 15
```

---

## 💡 Pro Tips

1. **Always test your scripts** - Don't assume they work
2. **Use meaningful variable names** - Not `x`, use `filename` or `count`
3. **Add comments** - Explain complex parts (your future self will thank you)
4. **Start simple** - Master basics before complex features
5. **Practice daily** - Consistency beats long sessions

---

## 🆘 Troubleshooting

### Problem: Permission denied when running `./script.sh`
**Solution:** 
```bash
chmod +x script.sh
./script.sh
```

### Problem: Command not found
**Solution:** Make sure you're in the correct directory with `pwd` and use `./script.sh` (with the dot)

### Problem: Variables not working
**Solution:** Make sure to use `$` before variable name: `echo $name` not `echo name`

### Problem: Script runs but output is wrong
**Solution:** Add `set -x` after shebang to debug:
```bash
#!/bin/bash
set -x  # This shows each command before executing
# rest of script
```

---

## 📞 Getting Help

When stuck:
1. Read error messages carefully (they tell you what's wrong!)
2. Use `bash -n script.sh` to check syntax
3. Use `bash -x script.sh` to see step-by-step execution
4. Search for the error message online
5. Test commands in interactive bash first, then add to script

---

## ✅ Mark Your Progress

- **Day 1 Start Time:** ___:___ AM/PM
- **Day 1 End Time:** ___:___ AM/PM
- **Total Time Spent:** ___ minutes
- **Confidence Level:** _/10
- **Next Day Ready:** ☐ Yes ☐ Almost ☐ Need review

---

## 🎉 Congratulations!

You've completed **Day 1 of 35**! You now understand:
- ✅ Bash script basics
- ✅ Variables and environment variables
- ✅ Basic user interaction (read/echo)
- ✅ Running executable scripts
- ✅ Comments and script structure

**34 days of learning ahead!** 

Keep going! The hardest part is getting started, and you've already done it! 🚀

---

**Next:** Day 2 - Variables, Data Types & Operators

