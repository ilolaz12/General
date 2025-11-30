#!/bin/bash
# Updated LaTeX Workflow Script with Equations and Output Folder Management

# Create output folder if it doesn't exist
OUTPUT_FOLDER="output"
mkdir -p "$OUTPUT_FOLDER"

# Prompt for input file and output file names
read -p "Enter the path to the input text file (e.g., distros.txt): " INPUT_FILE
read -p "Enter the name for the output LaTeX file (e.g., distros.tex): " OUTPUT_LATEX

# Verify the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "Error: File '$INPUT_FILE' not found!"
    exit 1
fi

# Ensure LaTeX file is saved in the output folder
OUTPUT_LATEX="$OUTPUT_FOLDER/$OUTPUT_LATEX"

# Generate PDF file name based on LaTeX file
OUTPUT_PDF="${OUTPUT_LATEX%.tex}.pdf"

# Step 1: Create a LaTeX document
echo "Creating LaTeX document..."
cat > "$OUTPUT_LATEX" <<EOL
\documentclass[12pt,a4paper]{article}
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage{wrapfig}

\begin{document}

\section{Linux Distros}
The following is a list of Linux distributions and their release dates:

\begin{table}[!h]
\centering
   \begin{tabular}{lcr}
   \hline
   Distro & Version & Release Date \\
   \hline
EOL

# Add data from the input text file to the LaTeX table
while IFS= read -r line; do
    echo "   $(echo $line | awk '{print $1 " & " $2 " & " $3 " \\\\"}')"
done < "$INPUT_FILE" >> "$OUTPUT_LATEX"

cat >> "$OUTPUT_LATEX" <<EOL
   \hline
   \end{tabular}
\caption{Table of Linux distros.}
\label{table:1}
\end{table}

There are many Linux distros available. Some are shown in Table \ref{table:1}.

\section{Equations in \LaTeX}
The sum of $n$ terms $a_1$, $a_2$, $a_3$, $\cdots$, $a_n$ is written:

\begin{equation}
\sum_{i=1}^{n} a_i = a_1 + a_2 + \cdots + a_n
\label{eq:sum}
\end{equation}

where $i$ is the index of summation, $a_i$ is the $i^{th}$ term of the sum, and the upper and lower bounds of summation are $n$ and $1$, respectively.

The summation formula is shown in Equation \ref{eq:sum}.

\section{Linux Tux}
\begin{figure}
   \centering
   \includegraphics[width=3cm]{tux.png}
   \caption{The Tux logo}
   \label{fig:tux}
\end{figure}

\end{document}
EOL

echo "LaTeX document created successfully!"

# Step 2: Compile the LaTeX document
echo "Compiling LaTeX document..."
pdflatex -output-directory="$OUTPUT_FOLDER" "$OUTPUT_LATEX"

if [[ $? -ne 0 ]]; then
    echo "Error: Failed to compile LaTeX file."
    exit 2
fi

# Verify the PDF was created
if [[ -f "$OUTPUT_PDF" ]]; then
    echo "PDF file '$OUTPUT_PDF' created successfully!"
else
    echo "Error: PDF file was not created!"
    exit 3
fi

# Step 3: View the PDF
read -p "Do you want to view the PDF now? (y/n): " VIEW_PDF
if [[ "$VIEW_PDF" == "y" || "$VIEW_PDF" == "Y" ]]; then
    if command -v atril &> /dev/null; then
        atril "$OUTPUT_PDF" &
    elif command -v okular &> /dev/null; then
        okular "$OUTPUT_PDF" &
    else
        echo "No PDF viewer found. Please open '$OUTPUT_PDF' manually."
    fi
else
    echo "PDF generation complete. You can view '$OUTPUT_PDF' at your convenience."
fi
