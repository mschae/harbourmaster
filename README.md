# Harbormaster

Super minimalistic docker-hub to slack posting with configurable routing!

## Usage

Cool hackers don't need fancy UIs...

### Subscribe a build to a channel

```
curl -X POST "http://localhost:9393/slack/channels" \
     -d "repo=<dockerhub_repo>" \
     -d "channel=<slack_channel_url>"
```

### List channels you're subscribed to

```
curl -X GET "http://192.168.59.103:49154/slack/channels"
```

### Unsubscribe a challen


```
curl -X DELETE "http://localhost:9393/slack/channels?repo=<repo>&channel=<channel>
```
