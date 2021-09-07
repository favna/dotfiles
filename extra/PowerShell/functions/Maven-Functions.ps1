Function maven {
    mvn -T 4.0C -pl !gms/gms-release -pl !sbc/sbc-release -pl !wli/wli-release -DskipTests -D"maven.javadoc.skip"=true -DskipRpms -D"skip.keten.tests"=true -D"skip.integration.tests"=false @Args
}

Function mvnci {
    maven clean install
}

Function mvni {
    maven install
}

Function mvnc {
    maven clean
}