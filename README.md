# pipelines

Prep cluster:

#1 - project:

oc new-project demo-pipelines

#2 - service account (for buildah, s2i etc.):

oc create sa pipeline

oc adm policy add-scc-to-user privileged -z pipeline

oc adm policy add-role-to-user edit -z pipeline

or

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/prep-cluster/01_ServiceAccount-pipeline.yaml

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/prep-cluster/02_ClusterRole-scc-privileged.yaml

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/prep-cluster/03_RoleBinding-scc-privileged.yaml

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/prep-cluster/04_RoleBinding-edit.yaml

#3 - PVC for shared-workspace

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/prep-cluster/resources/pvc.yaml

#4 - Create tasks:

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/tasks/apply-manifests.yaml

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/tasks/update_deployment_task.yaml

#5 - Create pipeline:

oc apply -f https://raw.githubusercontent.com/apoczekalewicz/pipelines/master/pipeline/build-and-deploy.yaml

#6 - Start pipeline - for vote-api and vote-ui:

tkn pipeline start build-and-deploy -w name=shared-workspace,claimName=source-pvc -p deployment-name=pipelines-vote-api -p git-url=https://github.com/apoczekalewicz/pipelines-vote-api.git -p IMAGE=image-registry.openshift-image-registry.svc:5000/$(oc project -q)/vote-api --showlog

tkn pipeline start build-and-deploy -w name=shared-workspace,claimName=source-pvc -p deployment-name=vote-ui -p git-url=https://github.com/apoczekalewicz/pipelines-vote-ui/ -p IMAGE=image-registry.openshift-image-registry.svc:5000/$(oc project -q)/vote-ui --showlog

Notes:
- We are using here shared-workspace with PVC to share some information between Tasks
- We are using here 2 application repos:
https://github.com/apoczekalewicz/pipelines-vote-api.git
https://github.com/apoczekalewicz/pipelines-vote-ui/


