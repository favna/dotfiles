Function maven {
    mvn -T 4.0C -pl !gms/gms-release -pl !sbc/sbc-release -pl !wli/wli-release -DskipTests @Args
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