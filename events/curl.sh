 URL="https://github.com/apoczekalewicz/pipelines-vote-ui" # GIT repo
 ROUTE_HOST=$(oc get route event --template='http://{{.spec.host}}')
 curl -v \
    -H 'X-GitHub-Event: pull_request' \
    -H 'Content-Type: application/json' \
    -d '{
      "repository": {"clone_url": "'"${URL}"'"},
      "pull_request": {"head": {"sha": "master"}}
    }' \
    ${ROUTE_HOST}
