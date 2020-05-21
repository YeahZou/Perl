#!/usr/bin/perl

my @arr = qw(
        balantflow-common
        balantflow-dto
        balantflow-dao
        balantflow-util
        balantflow-globalsearch-component
        balantflow-component
        balantflow-webservice
        balantflow-service
        balantflow-web
        balantflow-resource
        balantflow-tagent
        balantflow-octopus-component
        balantflow-ecmdb-component
        balantflow-module-case
        balantflow-module-deploy
        balantflow-module-change
        balantflow-module-contract
        balantflow-module-ecmdb
        balantflow-module-exagent
        balantflow-module-installation
        balantflow-module-knows
        balantflow-module-monitor
        balantflow-module-octopus
        balantflow-module-oputils
        balantflow-module-report
        balantflow-module-repository
        balantflow-module-supplier
);

print(join(', ', @arr));
