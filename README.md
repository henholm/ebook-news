#### Install terminal-notifier to show MacOS notifications.
`brew install terminal-notifier`


#### Set the script up as a cron job running every Saturday at 06:00 AM.
` $ sudo crontab -u $(whoami) -e `

` Password: `

` 0 6 * * 6 ~/path-to-this-directory/update-news.sh `

#### Log to stdout and stderr ...
` 0 6 * * 6 ~/path-to-this-directory/update-news.sh > /tmp/stdout.log 2> /tmp/stderr.log `


#### ... or to this directory:
` 0 6 * * 6 ~/path-to-this-directory/update-news.sh >> ~/path-to-this-directory/out.log 2>&1 `

#### List your cron jobs to see if everything was set up correctly:
` $ crontab -l `

` 0 6 * * 6 ~/path-to-this-directory/update-news.sh >> ~/path-to-this-directory/out.log 2>&1 `