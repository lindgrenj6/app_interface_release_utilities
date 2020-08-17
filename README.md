# App Interface release scripts

### Requirements
- gh (GitHub command line client for api access)
- jq (json cli processor)
- awk (black magic witchcraft language that you only see in hacky stuff like this)

1) `get_all_$(app)_shas.sh`

Run this to get the sha's to stick in your deploy.yml. 
Output is similar to this: 
```
ansible_tower: 484abf0
api: 9c565b2
azure: 24ff4fe
amazon: 327d395
openshift: 7fc8af1
persister: bf5fc1c
satellite: a275f27
orchestrator: 0471eda
ingress_api: 0e9f5b0
sync: e4db79a
```

