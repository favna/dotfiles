Function maven {
    mvn -T 4.0C -D"maven.javadoc.skip" @Args
}

Function mvnci {
    maven clean install @Args
}

Function mvni {
    maven install @Args
}

Function mvnc {
    maven clean @Arg
s}

Function mvnb {
    mvn install -T 4.0C -DskipTests -D"maven.javadoc.skip" @Args
}

Function mvnbc {
    mvn clean install -T 4.0C -DskipTests -D"maven.javadoc.skip" @Args
}