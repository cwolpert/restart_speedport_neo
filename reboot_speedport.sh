#!/bin/bash
#0. enter your speedport login credentials
#1. run ./restart_speedport.sh
# repository: https://github.com/cwolpert/restart_speedport_neo
# a similar project: https://github.com/Gia90/Fickport

speedport="speedport.ip"
# password to login at Speedport Neo
devpwd="password"

#login
#get session-id from cookie
sid=$(curl -v -c - 'http://speedport.ip/data/Login.json?lang=de' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/javascript, */*' -H 'Origin: http://speedport.ip' -H 'X-Requested-With: XMLHttpRequest' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Referer: http://speedport.ip/html/login/index.html?lang=de' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: de-DE,de;q=0.9,en-DE;q=0.8,en;q=0.7,fr-FR;q=0.6,fr;q=0.5,en-US;q=0.4' -H 'Cookie: lang=de' --data 'password=r0m30%23t1g3r&showpw=0&csrf_token=sercomm_csrf_token' --compressed --insecure | grep 'session_id' | grep -o -E '\b(\w+)$')
echo "[>] session-id: $sid"

#get csrf-token from index.html
csrftoken=$(curl 'http://speedport.ip/html/content/overview/index.html?lang=de' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' -H 'Referer: http://speedport.ip/html/login/index.html?lang=de' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: de-DE,de;q=0.9,en-DE;q=0.8,en;q=0.7,fr-FR;q=0.6,fr;q=0.5,en-US;q=0.4' -H "Cookie: lang=de; session_id=${sid}" --compressed --insecure | grep 'csrf' | grep -oE "('.*')")
#get rid of the ''
csrftoken=$(echo "${csrftoken//\'}")
echo "[>] csrf-token: $csrftoken"

#post request resart
curl "http://speedport.ip/data/Reboot.json?_time=1576887761389&_rand=6&csrf_token=${csrftoken}&lang=de" -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/javascript, */*' -H 'Origin: http://speedport.ip' -H 'X-Requested-With: XMLHttpRequest' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Referer: http://speedport.ip/html/content/config/problem_handling.html?lang=de' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: de-DE,de;q=0.9,en-DE;q=0.8,en;q=0.7,fr-FR;q=0.6,fr;q=0.5,en-US;q=0.4' -H "Cookie: lang=de; session_id=${sid}" --data "reboot_device=true&csrf_token=${csrftoken}" --compressed --insecure
echo "[>] REBOOT!"
