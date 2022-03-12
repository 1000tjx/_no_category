#!/usr/bin/env python
# -*- coding: utf-8 -*-

import tweepy

consumer_key = ""
consumer_secret = ""
access_key = ""
access_secret = ""


def oauth_login(consumer_key, consumer_secret):
    """Authenticate with twitter using OAuth"""

    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth_url = auth.get_authorization_url()

    verify_code = input(
        "Authenticate at %s and then enter you verification code here > " % auth_url)
    auth.get_access_token(verify_code)

    return tweepy.API(auth)


def batch_delete(api):
    print("Deleting all tweets from the account @%s." %
          api.verify_credentials().screen_name)
    for status in tweepy.Cursor(api.user_timeline).items():
        try:
            api.destroy_status(status.id)
            print("Deleted:", status.id)
        except:
            print("Failed to delete:", status.id)


def run_unlike():
    def unlike_tweet(api, status_id):
        try:
            api.destroy_favorite(status_id)
            print("Removed favorite: ", status_id)
        except:
            print("Could not unfavorite tweet: ", status_id)

    index = 0
    for tweet in tweepy.Cursor(api.favorites).items():
        try:
            # t = threading.Thread(target=unlike_tweet, args=(api, tweet.id))
            unlike_tweet(api, tweet.id)
            index += 1
            print("Running unlike number %s" % index)
            t.start()
        except:
            print("Unfavorite could not start on tweet %s" % tweet.id)


if __name__ == "__main__":
    # authorize twitter, initialize tweepy
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_key, access_secret)
    api = tweepy.API(auth)
    print("Authenticated as: %s" % api.me().screen_name)

    print("Please enter your option: ")
    print("1 - Delete my tweets")
    print("2 - Unlike all")
    option = input("option : ")
    if(option == '1'):
        batch_delete(api)
    elif(option == '2'):
        run_unlike()
