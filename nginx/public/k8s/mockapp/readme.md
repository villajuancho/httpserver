curl -d POST 'http://192.168.88.27:30025/getToken' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=api-caller' \
--data-urlencode 'client_secret=nPR0ZxpeizVQwhbxekGmSOJ7ddv8Kb4D' \
--data-urlencode 'grant_type=client_credentials'



curl -X POST http://192.168.88.27:30025/mockapp -d hola=juan


curl -X POST http://192.168.88.27:30025/mockapp \
--header 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIg8Q' \
--header 'Content-Type: application/json' \
-d hola=juan
