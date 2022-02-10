# JWNC Uptime Monitor

This is a very basic Laravel app with Spatie's [Laravel Uptime Monitor](https://spatie.be/docs/laravel-uptime-monitor/v3/introduction) pulled in to do some http and ssl monitoring.

## Usage

This is designed to be run using `docker compose`.  Assuming you have that installed then to run the app you can do :
```bash
export MAIL_HOST=smtp.example.com
export MAIL_FROM_ADDRESS=you@example.com
export UPTIME_MONITOR_ALERT_EMAIL=someone@example.com,someone-else@example.com
# optionally
export UPTIME_MONITOR_SLACK_WEBHOOK_URL=https://slack.com/......
```
Now create a file called `sites.txt` and put one URL per line, eg:
```
https://www.example.com
https://images.example.com
```
Then run the app :
```bash
docker compose up --build # add -d if you want it to run in the background
```

## Running in production

If you want to use this 'for real' then it would be worth editing the `docker-compose.yml` file and hard-coding the values for some of the environment variables.  Otherwise on a reboot the service will restart but have lost all the values for `MAIL_HOST` etc.

