#! /bin/bash
#requires: sendmail

function fappend {
    echo "$2">>$1;
}

# CHANGE THESE
toemail="";
fromemail="";
subject="";
msgbody="";

# DON'T CHANGE ANYTHING BELOW
TMP=`mktemp`;

rm -rf $TMP;
fappend $TMP "From: $fromemail";
fappend $TMP "To: $toemail";
fappend $TMP "Reply-To: $fromemail";
fappend $TMP "Subject: $subject";
fappend $TMP "";
fappend $TMP "$msgbody";
fappend $TMP "";
fappend $TMP "";
cat $TMP|/usr/sbin/sendmail -t;
rm $TMP;
fi
