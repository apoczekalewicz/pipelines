tkn pipeline start build-and-deploy -w name=shared-workspace,claimName=source-pvc -p deployment-name=vote-ui -p git-url=https://github.com/openshift-pipelines/vote-ui.git -p IMAGE=image-registry.openshift-image-registry.svc:5000/`oc project -q`/vote-ui --showlog