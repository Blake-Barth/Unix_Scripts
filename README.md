# 🖥️ Shell & Perl Scripting Projects

This repository showcases a collection of Shell and Perl scripts made for my UNIX TOOLS class demonstrating scripting proficiency. These scripts include system utilities, data processing tools, and text manipulation programs.

---

## 📁 Script Overview

| Script        | Language | Description                                           |
|---------------|----------|-------------------------------------------------------|
| `cal.sh`      | Shell    | Custom calendar display with optional month/year args |
| `junk.sh`     | Shell    | Moves files to a hidden `.junk` directory             |
| `phonebook.sh`| Shell    | Contact manager supporting add/delete/modify/search   |
| `plot.sh`     | Shell    | Plots data from a text file using `gnuplot`           |
| `justify.pl`  | Perl     | Justifies text to a specified column width            |
| `freq.pl`     | Perl     | Calculates word frequencies from standard input       |
| `head.pl`     | Perl     | Displays up to 10 lines from standard input           |
| `justify.pl`  | Perl     | Formats and justifies paragraphs to a given width     |
| `middle.pl`   | Perl     | Prints the middle *n* lines from standard input       |

---

## 🧪 How to Run

### Shell Scripts

```bash
chmod +x scriptname.sh
./scriptname.sh
```

### Perl Scripts

```bash
chmod +x wordfreq.pl
cat input.txt | ./wordfreq.pl
```

You can also run it interactively by typing directly into standard input:

```bash
./wordfreq.pl
Type your input text here
Press CTRL+D to end input
```

---

## 📚 Learning Objectives

- Demonstrate knowledge of:
  - Shell control structures (if/else, loops)
  - File manipulation
  - String processing
  - Perl regular expressions
  - Hashes, sorting, and text formatting
- Practice scripting for real-world CLI tools

---

## 🔧 Requirements

- Bash-compatible shell (Linux/macOS/WSL)
- Perl (pre-installed on most Unix-based systems)

---
