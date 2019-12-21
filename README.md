# restart_speedport_neo

Sometimes my **Telekom Speedport Neo** seems to forget port forwarding settings and ddns updates. 

Rebooting the router helps, so I wrote a little bash script to automate it.

The curl commands were extraced directly from google chrome's developer console (F12).

#Technical description:
To restart the router, both session-id and csrf-token are required:
* session-id is stored in a cookie upon first connection. 
* csrf-token can be found in the index.html source code after login.

You might also want to check out https://github.com/Gia90/Fickport

