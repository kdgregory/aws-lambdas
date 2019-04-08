Emulates an RDS 9.6 Postgres instance, for testing of database code that might rely on being superuser.

Specific changes:

    * `rdsadmin` is superuser, and there's no way to log in as it.
    * `postgres` is a normal user with the addition of `CREATEDB` and `CREATEROLE` privileges.
