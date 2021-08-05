unmailboxes *

set my_email=tkiatd@outlook.com

set folder=imaps://$my_email@outlook.office365.com:993
set from=$my_email
set imap_pass=`pass show t/microsoft-tkiatd`
set imap_user=$my_email
set smtp_pass=`pass show t/microsoft-tkiatd`
set smtp_url=smtp://$my_email@smtp.office365.com:587

set postponed=+Drafts
set record=+Sent
set spoolfile=+Inbox

# set ssl_force_tls=yes
set ssl_starttls=yes

account-hook $folder "set imap_user=$my_email imap_pass=$imap_pass"
