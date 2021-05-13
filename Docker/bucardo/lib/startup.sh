#!/bin/bash

service postgresql start
su - postgres -c "psql -U postgres -d postgres -c \"Alter role bucardo login password 'selab';\""
