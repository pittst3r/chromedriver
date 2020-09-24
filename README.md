# pittst3r/chromedriver

A docker image that runs chromedriver.

## How to Use

### docker-compose.yml

```yml
version: '3.8'

services:
  chromedriver:
    image: pittst3r/chromedriver:latest
    # Chrome can't start without this. You can also set it to `seccomp=chrome.json`
    # if you download the chrome.json file from this git repo and place it next to
    # your docker-compose.yml
    security_opt: 
      - seccomp=unconfined
    ports:
      - "4567:4567"
      - "9222:9222"
```

```
$ docker-compose up
```

Then you can send webdriver requests to http://localhost:4567 on your host. Once you start a
session you can navigate to `chrome://inspect` on your host and view, inspect, and debug your session.

To start a session, send a request like this:

```sh
curl --location --request POST 'http://localhost:4567/session' \
--header 'Content-Type: application/json' \
--data-raw '{
    "capabilities": {
        "alwaysMatch": {
            "goog:chromeOptions": {
                "args": [
                    "--headless",
                    "--user-data-dir=/home/chrome/data",
                    "--disable-gpu",
                    "--remote-debugging-address=0.0.0.0",
                    "--remote-debugging-port=9222"
                ]
            }
        }
    }
}'
```
