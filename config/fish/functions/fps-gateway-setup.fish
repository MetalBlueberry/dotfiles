function fps-gateway-setup
    if test -z "$F3_VERSION"
        echo "F3 must be activated first"
        return 1
    end
    if test -z "$GITHUB_TOKEN"
        echo "GITHUB_TOKENF must be exported first"
        return 1
    end
    if test -z "$AWS_SECRET_ACCESS_KEY"
        echo "f3 aws must be run first"
        return 1
    end

    export MQ="true"                 
    export ELK="false"               
    export MONITORING="false"

    export MINIKUBE_CFG="--cpus 12 --kubernetes-version v1.18.8 --memory=15g --disk-size=300g"
    make docker-login
    make helm-pre-skaffold-template
    make minikube-setup
end
