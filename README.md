#### Install terminal-notifier to show MacOS notifications.
`brew install terminal-notifier`

#### Schedule the shell script to run, e.g., daily with a .plist file.
`com.user.updateNews.plist`

#### symlink the .plist file in this directory to a file in ~/Library/LaunchAgents
` ln -s com.user.updateNews.plist ~/Library/LaunchAgents/com.user.updateNews.plist `


#### Alternatively, set up the script as a cron job, e.g., running every Saturday at 06:00 AM.
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

