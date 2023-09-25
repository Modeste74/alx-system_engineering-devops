#!/usr/bin/python3
"""uses api to retrieve and return data"""
import json
import requests
from sys import argv


def export_to_json(user_id, username, tasks):
    """exports data in json format"""
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
    export_to_json(user_id, employee_name, todos_data)
