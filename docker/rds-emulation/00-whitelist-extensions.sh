sed -i \
    -e "/local_preload_libraries/a extwlist.extensions='dblink,ltree,pgcrypto'" \
    -e "s/^#local_preload_libraries.*''/local_preload_libraries='pgextwlist'/" \
    /var/lib/postgresql/data/postgresql.conf
