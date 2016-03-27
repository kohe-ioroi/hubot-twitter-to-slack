Twit = require "twit"
Q = require "q"
_ = require "lodash"

#######################################################
#                    config                           #
#######################################################
ROOM = process.env.HUBOT_TTS_ROOM
query = process.env.HUBOT_TTS_QUERY
MAX_TWEETS = process.env.HUBOT_MAX_TWEETS
CONFIG = {
  consumer_key: process.env.HUBOT_TTS_CONSUMER_KEY,
  consumer_secret: process.env.HUBOT_TTS_CONSUMER_SECRET,
  access_token: process.env.HUBOT_TTS_ACCESS_TOKEN_KEY,
  access_token_secret: process.env.HUBOT_TTS_ACCESS_TOKEN_SECRET
}


module.exports = (robot) ->
  messages = []
#######################################################
#                    function                         #
#######################################################
  createTwit = ->
    return new Twit CONFIG

  saveSinceId = (data) ->
    sinceId = getLatestSinceId(data)
    robot.brain.set('ntts_last_tweet', sinceId)
    robot.brain.save()

  getSinceId = () ->
    return robot.brain.get('ntts_last_tweet')

  addMessage = (message) ->
    messages.push(message)

  getLatestSinceId = (data)->
    return data.statuses[0].id_str

  sendMessage = (robot, ROOM, messages) ->
    message = messages.shift()
    if message != undefined
      robot.messageRoom ROOM, message

  getTweet = ()->
    dfd = Q.defer()
    twit = createTwit()
    twit.get 'search/tweets', {q: query, count: MAX_TWEETS, since_id: getSinceId()}, (err, data) ->
      if err
        dfd.reject(err)
        return
      dfd.resolve(data)
    return dfd.promise;

  twitterSearchStart = (robot) ->
    getTweet().then((data) ->
      if data.statuses? && data.statuses.length > 0
        saveSinceId(data)
        _.each(data.statuses.reverse(), (tweet) ->
          message = "Tweet: http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id_str}?id=#{tweet.id_str}"
          addMessage(message)
        )
      else
        console.log "nothing tweet since since_id:#{since_id}"

    ).fail((err) ->
      messages = ['error for twitter search']
      sendMessage(robot, ROOM, messages)
    )

#######################################################
#                      do                             #
#######################################################
  setTimeout (->
      twitterSearchStart(robot)
  ), 1000 * 60 * 2

  setInterval (->
      sendMessage(robot, ROOM, messages)
  ), 1000 * 3
