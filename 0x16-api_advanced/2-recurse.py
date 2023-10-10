#!/usr/bin/python3
"""defines a function"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """queries the reddit api and returns
    list containing title of hot articles"""
    url = 'https://www.reddit.com/r/{}/hot.json?limit=100'.format(subreddit)
    url += '&after={}'.format(after)
    header = {'User-Agent': 'CustomBot/1.0'}
    response = requests.get(url, headers=header, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        after = data['data']['after']
        for post in posts:
            hot_list.append(post['data']['title'])
        if after is not None:
            return recurse(subreddit, hot_list, after)
        else:
            return hot_list
    else:
        return None
