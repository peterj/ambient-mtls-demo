#!/bin/bash

# Sends the requests from the client to the server.
# The client defaults to "deploy/client" and the server defaults to "http://httpbin:8000/anything"

# Usage: ./traffic.sh <client> <server>
# Example: ./traffic.sh deploy/client http://httpbin:8000/anything

USERNAMES=("john.doe" "jane.smith" "bob.jones" "alice.johnson" "charlie.brown")
PASSWORDS=("password123" "iloveyou" "123456" "password" "123456789" "admin" "123123" "qwerty" "abc123" "letmein" "monkey" "111111" "password1" "qwerty123" "dragon" "1234" "baseball" "iloveyou" "trustno1" "sunshine" "princess" "football" "welcome" "shadow" "superman" "michael" "ninja" "mustang" "jessica" "charlie" "ashley" "bailey" "passw0rd" "master" "love" "hello" "freedom" "whatever" "nicole" "jordan" "cameron" "secret" "summer" "1q2w3e4r" "zxcvbnm" "starwars" "computer" "taylor" "startrek")

CLIENT=${1:-deploy/client}
SERVER=${2:-http://server:8000/anything}

echo "Sending traffic from $CLIENT to $SERVER"

i=0
while true; do
    CC=$(shuf -i 1000000000000000-9999999999999999 -n 1)
    CCV=$(shuf -i 2321-9999 -n 1)
    YEAR=$(shuf -i 2024-2050 -n 1)
    MONTH=$(shuf -i 1-12 -n 1)

    RANDOM_USERNAME_INDEX=$(( $RANDOM % ${#USERNAMES[@]} ))
    RANDOM_PASSWORD_INDEX=$(( $RANDOM % ${#PASSWORDS[@]} ))

    USERNAME=${USERNAMES[$RANDOM_USERNAME_INDEX]}
    PASSWORD=${PASSWORDS[$RANDOM_PASSWORD_INDEX]}

    kubectl exec -it $CLIENT -c client -- sh -c "curl -s -o /dev/null -w '$i: %{http_code}\n' -H 'username: $USERNAME' -H 'password: $PASSWORD' -X POST -d 'cc_number=$CC&exp_date=$MONTH/$YEAR&cvv=$CCV' $SERVER"
    sleep 1
    i=$((i+1))
done
