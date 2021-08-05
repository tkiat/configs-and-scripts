unmailboxes *

set my_email=johndonut751@gmail.com

set folder=imaps://johndonut751@imap.gmail.com:993
set from=$my_email
set imap_pass=`pass show t/gmail`
set imap_user=$my_email
set smtp_pass=`pass show t/gmail`
set smtp_url=smtp://johndonut751@smtp.gmail.com:587

set postponed=+[Gmail]/Drafts
set record="+[Gmail]/Sent Mail"
set spoolfile=+Inbox

set ssl_force_tls=no
set ssl_starttls=no

account-hook $folder "set imap_user=$my_email imap_pass=$imap_pass"
