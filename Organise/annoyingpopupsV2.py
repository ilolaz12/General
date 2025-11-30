import tkinter as tk
from tkinter import messagebox
import json

# File to store the task data
task_file = "ml_tasks.json"

# Load tasks from the file, or use default if file doesn't exist
try:
    with open(task_file, "r") as file:
        tasks = json.load(file)
except FileNotFoundError:
    tasks = {
        "Week 1": ["Define project scope", "Research ML techniques", "Decide on tech stack"],
        "Week 2": ["Install Python and IDE", "Explore tutorials"],
        # Add all your weeks and tasks here
    }

def complete_task(week, task):
    tasks[week].remove(task)
    update_task_list()
    with open(task_file, "w") as file:
        json.dump(tasks, file)
    messagebox.showinfo("Task Completed", f"Completed: {task}")

def update_task_list():
    for widget in frame.winfo_children():
        widget.destroy()
    for week, week_tasks in tasks.items():
        tk.Label(frame, text=week, font=("Helvetica", 16)).pack()
        for task in week_tasks:
            task_button = tk.Button(frame, text=task, command=lambda t=task: complete_task(week, t))
            task_button.pack()

root = tk.Tk()
root.title("ML Setup Tracker")

frame = tk.Frame(root)
frame.pack(padx=10, pady=10)

update_task_list()

root.mainloop()
