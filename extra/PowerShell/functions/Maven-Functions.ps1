Function maven {
    mvn -T 4.0C -pl !gms/gms-release -pl !sbc/sbc-release -pl !wli/wli-release -DskipTests -D"maven.javadoc.skip" -DskipRpms -D"skip.keten.tests" -D"skip.integration.tests" @Args
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