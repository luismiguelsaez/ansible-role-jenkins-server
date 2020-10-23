This ansible role installs jenkins server from official repositories

## Testing

### Create and activate python virtualenv
```
$ virtualenv -p $(which python3) .venv
$ . .venv/bin/activate
```

### Install python requirements
```
(.venv) $ pip install -r requirements.txt
```

### Test role
```
(.venv) $ molecule converge
(.venv) $ molecule idempotence
(.venv) $ molecule destroy
```

## Connect to server

Once the server is deployed, you can access and test it through http://127.0.0.1:8080/

Configuration as code ( CasC ) reference could be acceshed through http://127.0.0.1:8080/configuration-as-code/reference
