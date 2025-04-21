# 📦 JADX Setup Script for Ubuntu

This repository provides a bash script to **install or uninstall [JADX](https://github.com/skylot/jadx)** on Ubuntu systems.

> JADX is a command-line and GUI tool for reverse engineering Android applications. It can decompile `.apk` and `.dex` files into readable Java source code and decode resources like XML files and images.

---

## 🛠️ Features of this Script

✅ Automatically installs dependencies  
✅ Downloads the latest JADX release  
✅ Installs both CLI (`jadx`) and GUI (`jadx-gui`)  
✅ Adds JADX to system PATH for global access  
✅ Option to uninstall everything cleanly  
✅ Simple number-based interactive menu  

---

## 📂 Repository Contents

- `jadx-setup.sh` – The interactive bash script
- `README.md` – This documentation file

---

## 📌 Requirements

- Ubuntu 18.04 / 20.04 / 22.04
- `sudo` privileges
- `curl`, `unzip`, `zip`
- Java installed

> Install Java if you haven’t already:
```bash
sudo apt install -y default-jdk
