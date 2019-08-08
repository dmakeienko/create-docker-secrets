# Create Docker Secrets script

## General info

Script will create docker secret from provided values. It won't store commands in session history file, so your secrets won't be exposed.

## Usage

```
bash create_secret.sh [-h] [-n name] [-v value] [-f /path/to/file]-- script to create docker secrets
where:
    -h show this help text
    -f /path/to/file
    -n secret name (required)
    -v secret value (required)

```

### Provide secret via script arguments

```
    bash create_secret.sh -n my_secret -v secret_value
```
 
### Provide secret via file

```
  bash create_secret.sh -f ~/var/www/env_file
```

`NOTE!` File should be properly formatted:

```
secret_name=secret_value
SECRET_NAME=SECRET_VALUE

```

`PLEASE BE AWARE THAT YOU NEED A NEWLINE AT THE END`