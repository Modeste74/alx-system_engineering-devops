#!/usr/bin/python3
"""uses api to retrieve and display data"""
import json
import requests


def export_to_json_all_employees(employees_data):
    data = {}
    for user_id, user_info in employees_data.items():
        tasks = user_info["tasks"]
        user_name = user_info["name"]
        user_tasks = []
        for task in tasks:
            user_tasks.append({
                "username": user_name,
                "task": task.get("title"),
                "completed": task.get("completed")
                })
        data[user_id] = user_tasks
    file_name = "todo_all_employees.json"
    with open(file_name, 'w') as file:
        json.dump(data, file)


if __name__ == "__main__":
    base_url = "https://jsonplaceholder.typicode.com"
    users_response = requests.get(f"{base_url}/users")
    users_data = users_response.json()
    employees_data = {}
    for user in users_data:
        user_id = str(user.get("id"))
        user_name = user.get("name")
        todos_response = requests.get(f"{base_url}/users/{user_id}/todos")
        todos_data = todos_response.json()
        employees_data[user_id] = {
            "name": user_name,
            "tasks": todos_data
            }
    export_to_json_all_employees(employees_data)
