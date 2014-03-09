# Description:
#   Stores the brain in Orchestrate.io
#
# Dependencies:
#   "orchestrate": "~0.0.5"
#
# Configuration:
#   ORCHESTRATE_API_KEY
#
# Commands:
#   NONE
#
# Notes:
#   Creates the brain data under a 'hubot' collection and 'brain' key.
#
# Author:
#   housejester (http://github.com/housejester/orchestrate-brain)

module.exports = (robot) ->
  oio = require('orchestrate')(process.env.ORCHESTRATE_API_KEY)
  oio.get('hubot', 'brain').then((res) -> robot.brain.mergeData res.body )
  robot.brain.on 'save', (data) -> oio.put('hubot', 'brain', data)