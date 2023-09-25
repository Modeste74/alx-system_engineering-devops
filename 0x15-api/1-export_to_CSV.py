#!/usr/bin/python3
"""uses api to retrieve and return data"""
import csv
import requests
from sys import argv


def export_to_csv(user_id, user_name, tasks):
    """exports the data to csv format"""
    file_name = f"{user_id}.csv"
    with open(file_name, 'w', newline='') as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)
        for task in tasks:
            writer.writerow(
                [user_id, user_name, task["completed"], task["title"]])


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
    total_tasks = len(todos_data)
    export_to_csv(user_id, employee_name, todos_data)
