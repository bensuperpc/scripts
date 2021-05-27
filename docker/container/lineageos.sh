docker run \
    -e "BRANCH_NAME=lineage-18.1" \
    -e "DEVICE_LIST=guacamole" \
    -e "SIGN_BUILDS=true" \
    -e "SIGNATURE_SPOOFING=restricted" \
    -e "CUSTOM_PACKAGES=GmsCore GsfProxy FakeStore MozillaNlpBackend NominatimNlpBackend com.google.android.maps.jar FDroid FDroidPrivilegedExtension " \
    -v "/home/bensuperpc/lineage/lineage:/srv/src" \
    -v "/home/bensuperpc/lineage/zips:/srv/zips" \
    -v "/home/bensuperpc/lineage/logs:/srv/logs" \
    -v "/home/bensuperpc/lineage/cache:/srv/ccache" \
    -v "/home/bensuperpc/lineage/keys:/srv/keys" \
    -v "/home/bensuperpc/lineage/manifests:/srv/local_manifests" \
    lineageos4microg/docker-lineage-cicd
