# hubot-twitter-to-slack

this sends the search results of twitter to slack.
The usage is very simple.

Have fun.

#Usage

Please write the following information in the bin / hubot file.

```
export HUBOT_TTS_CONSUMER_KEY=XXXXXXXXXXXX
export HUBOT_TTS_CONSUMER_SECRET=XXXXXXXX
export HUBOT_TTS_ACCESS_TOKEN_KEY=XXXXXXX
export HUBOT_TTS_ACCESS_TOKEN_SECRET=XXXXXXXXXXXX
export HUBOT_TTS_QUERY='today is'
export HUBOT_TTS_ROOM='#what_a_beautiful_day'
export HUBOT_MAX_TWEETS=5
```

#description of the configuration

TwitterOAuth of configuration

```
HUBOT_TTS_CONSUMER_KEY
HUBOT_TTS_CONSUMER_SECRET
HUBOT_TTS_ACCESS_TOKEN_KEY
HUBOT_TTS_ACCESS_TOKEN_SECRET
```

Search string

```
HUBOT_TTS_QUERY
```

Channel of slack that you want to notify

```
HUBOT_TTS_ROOM
```



