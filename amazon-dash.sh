#!/bin/sh

send_email_with_aws()
{
    # https://coderwall.com/p/3vqf2g/send-emails-via-amazon-ses-with-bash-and-curl
    TO="Julia A <success@simulator.amazonses.com>"
    FROM="IoT Device <dont-reply@testme.net>"
    SUBJECT="<$1>"
    MESSAGE="<$2>"
    AWS_ACCESS_KEY=ABCD1234
    AWS_SECRET_KEY=QWERTY9876

    date="$(date -R)"
    priv_key="$AWS_SECRET_KEY"
    access_key="$AWS_ACCESS_KEY"
    signature="$(echo -n "$date" | openssl dgst -sha256 -hmac "$priv_key" -binary | base64 -w 0)"
    auth_header="X-Amzn-Authorization: AWS3-HTTPS AWSAccessKeyId=$access_key, Algorithm=HmacSHA256, Signature=$signature"
    endpoint="https://email.eu-west-1.amazonaws.com/"

    action="Action=SendEmail"
    source="Source=$FROM"
    to="Destination.ToAddresses.member.1=$TO"
    subject="Message.Subject.Data=$SUBJECT"
    message="Message.Body.Text.Data=$MESSAGE"

    curl -v -X POST -H "Date: $date" -H "$auth_header" --data-urlencode "$message" --data-urlencode "$to" --data-urlencode "$source" --data-urlencode "$action" --data-urlencode "$subject"  "$endpoint"

}

order_eggies()
{
    send_email_with_aws "TIME TO BUY EGGIES" "Time to buy new eggies: https://www.nemlig.com/aeg-str-m-l-xl-oeko-5017510"
}

while true
do
    # -t 1 read every second
    # -n 1 return only after reading exactly 1 characters
    read -t 1 -n 1 key

    if [[ $key = e ]]
    then
        order_eggies
        # delete the standard input
        unset key
        continue
    fi
done
