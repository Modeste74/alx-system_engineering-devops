#!/usr/bin/python3
"""uses api to retrieve and return data"""
import requests
from sys import argv
import json


def export_to_json(user_id, username, tasks):
    data = {
        f"{user_id}": [
            {
                "task": task["title"],
                "completed": task["completed"],
                "username": username
                } for task in tasks
            ]
        }
    file_name = f"{user_id}.json"
    with open(file_name, 'w') as file:
        json.dump(data, file)


if __name__ == "__main__":
    user_id = argv[1]
    base_url = "https://jsonplaceholder.typicode.com"
    user_url = f"{base_url}/users/{user_id}"
    todos_url = f"{base_url}/todos?userId={user_id}"
    user_response = requests.get(user_url)
    todos_response = requests.get(todos_url)
    users_data = user_response.json()
    todos_data = todos_response.json()
    employee_name = users_data["name"]
    """total_tasks = len(todos_data)
    completed_task = []
    for task in todos_data:
        if task["completed"]:
            completed_task.append(task["title"])
    print("Employee {} is done with tasks({}/{}):"
          .format(employee_name, len(completed_task), total_tasks))
    for task in completed_task:
        print("\t{}".format(task))"""
    export_to_json(user_id, employee_name, todos_data)
