#!/bin/bash

CONFIG_FILE=_config.yml

# Local preview only: development mode skips minification, _config.dev.yml skips image resizing,
# and building into the container's /tmp avoids slow writes to the Windows-mounted repo folder.
SERVE_CMD="rm -f Gemfile.lock && JEKYLL_ENV=development exec bundle exec jekyll serve --config _config.yml,_config.dev.yml --destination /tmp/_site --watch --port=8080 --host=0.0.0.0 --livereload --trace --force_polling"

/bin/bash -c "$SERVE_CMD"&

while true; do

  inotifywait -q -e modify,move,create,delete $CONFIG_FILE

  if [ $? -eq 0 ]; then
 
    echo "Change detected to $CONFIG_FILE, restarting Jekyll"

    jekyll_pid=$(pgrep -f jekyll)
    kill -KILL $jekyll_pid

    /bin/bash -c "$SERVE_CMD"&

  fi

done
