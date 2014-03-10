# Description:
#   Stores the brain in Orchestrate.io
#
# Dependencies:
#   "orchestrate": "~0.0.5"
#
# Configuration:
#   ORCHESTRATE_API_KEY
#   ORCHESTRATE_COLLECTION (defaults to 'hubot:brain')
#
# Commands:
#   NONE
#
# Notes:
#   Creates the brain data under a collection where each property key/value in
#   the brain data is a separate item key/value in orchestrate.js.
#
# Author:
#   James Estes (http://github.com/housejester/orchestrate-brain)

module.exports = (robot) ->
  COLLECTION_NAME = process.env.ORCHESTRATE_COLLECTION || 'hubot:brain'
  BRAIN_JSON_CACHE = {}
  oio = require('orchestrate')(process.env.ORCHESTRATE_API_KEY)

  load_data = (res) ->
    if res.body.next
      url = 'https://' + oio.constructor.ApiEndPoint + res.body.next.substring(3)
      oio._get(url).then load_data

    for item in res.body.results
      BRAIN_JSON_CACHE[item.path.key] = JSON.stringify item.value
      robot.brain.mergeData item.value

  oio.list(COLLECTION_NAME, 100).then load_data

  robot.brain.on 'save', (data) ->
    for property of data
      wrapped = {}
      wrapped[property] = data[property]
      json = JSON.stringify wrapped
      if json != BRAIN_JSON_CACHE[property]
        oio.put COLLECTION_NAME, property, wrapped
        BRAIN_JSON_CACHE[property] = json
