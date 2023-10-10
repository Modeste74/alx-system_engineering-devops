#!/usr/bin/python3
"""defines a function count_words"""
import requests


def count_words(subreddit, word_list, after=None, counts=None):
    """returns a sorted list of word and count"""
    if counts is None:
        counts = {}
    url = "https://www.reddit.com/r/{}/hot.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0'}
    params = {'limit': 100, 'after': after}
    response = requests.get(
        url, headers=headers, params=params, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        after = data['data']['after']
        for post in posts:
            title = post['data']['title'].lower()
            for word in word_list:
                if word.lower() in title:
                    counts[word.lower()] = counts.get(
                        word.lower(), 0) + title.count(word.lower())
        if after is not None:
            count_words(subreddit, word_list, after, counts)
        else:
            sorted_counts = sorted(
                counts.items(), key=lambda x: (-x[1], x[0]))
            for word, count in sorted_counts:
                print("{}: {}".format(word, count)
    else:
        return
