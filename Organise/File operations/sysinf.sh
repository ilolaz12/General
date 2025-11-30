#!/bin/bash
# Advanced program to output a comprehensive system information and health check report

# Basic System Information
HOSTNAME=$(hostname)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
CPU_INFO=$(lscpu | grep "Model name" | awk -F ': ' '{print $2}')
MEM_INFO=$(free -h | awk '/^Mem:/ {print $2 " total, " $3 " used, " $4 " free"}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $2 " total, " $3 " used, " $4 " available"}')

# Network Information
IP_ADDRESS=$(hostname -I | awk '{print $1}')
DNS_SERVERS=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}' | paste -sd ", ")
GATEWAY=$(ip route | grep default | awk '{print $3}')

# Network and Domain Connectivity Tests
PING_GOOGLE=$(ping -c 1 google.com > /dev/null 2>&1 && echo "Reachable" || echo "Not reachable")
DNS_LOOKUP=$(nslookup google.com | grep 'Address' | tail -n 1 | awk '{print $2}')
if [ -z "$DNS_LOOKUP" ]; then
  DNS_LOOKUP="Failed to resolve"
fi

# System Health
LOAD_AVERAGE=$(uptime | awk -F 'load average: ' '{print $2}')
ACTIVE_SERVICES=$(systemctl --type=service --state=active | grep running | wc -l)
INACTIVE_SERVICES=$(systemctl --type=service --state=failed | wc -l)

# Package Update Check (works on Debian-based systems)
if command -v apt-get >/dev/null 2>&1; then
  UPDATES_AVAILABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing" | wc -l)
elif command -v yum >/dev/null 2>&1; then
  UPDATES_AVAILABLE=$(yum check-update | wc -l)
else
  UPDATES_AVAILABLE="Unable to check (unsupported package manager)"
fi

# Create the LaTeX document with comprehensive system information
echo "\documentclass{article}
\title{Comprehensive System Information and Health Check Report}
\author{${USER}}
\begin{document}
\maketitle

\section*{System Information}
\begin{itemize}
  \item \textbf{Hostname:} ${HOSTNAME}
  \item \textbf{Kernel Version:} ${KERNEL}
  \item \textbf{Uptime:} ${UPTIME}
  \item \textbf{CPU Model:} ${CPU_INFO}
  \item \textbf{Memory Usage:} ${MEM_INFO}
  \item \textbf{Disk Usage:} ${DISK_USAGE}
\end{itemize}

\section*{Network Information}
\begin{itemize}
  \item \textbf{IP Address:} ${IP_ADDRESS}
  \item \textbf{DNS Servers:} ${DNS_SERVERS}
  \item \textbf{Gateway:} ${GATEWAY}
\end{itemize}

\section*{Network and Domain Connectivity}
\begin{itemize}
  \item \textbf{Ping Google.com:} ${PING_GOOGLE}
  \item \textbf{DNS Lookup for Google.com:} ${DNS_LOOKUP}
\end{itemize}

\section*{System Health}
\begin{itemize}
  \item \textbf{Load Average:} ${LOAD_AVERAGE}
  \item \textbf{Active Services:} ${ACTIVE_SERVICES} (Running)
  \item \textbf{Inactive Services:} ${INACTIVE_SERVICES} (Failed)
  \item \textbf{Package Updates Available:} ${UPDATES_AVAILABLE}
\end{itemize}

\end{document}" > sysinfo.tex

# Wait for the file to be written
sleep 1

# Generate the PDF from the LaTeX document
pdflatex sysinfo.tex 1>/dev/null 2>&1

echo "PDF Created: sysinfo.pdf"
sleep 1

# Clean up temporary files created by pdflatex
#echo "Cleaning up temporary files..."
#rm sysinfo.tex sysinfo.aux sysinfo.log

# End of Script
