# orchestrate-brain

Hubot brain that stores the brain in orchestrate.io

## Getting Started
1. Install: `npm install orchestrate-brain`
2. Configure (see below)
3. Add `orchestrate-brain` to external-scripts.json in your hubot directory
4. Fire up your hubot

## Configuration
```
# Required, need an api key to talk to Orchestrate.
export ORCHESTRATE_API_KEY="[your orchestrate api key]"
# Optional, defaults to 'hubot:brain'
export ORCHESTRATE_COLLECTION="hubot:brain"
```
