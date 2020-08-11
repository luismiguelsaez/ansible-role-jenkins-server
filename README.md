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
