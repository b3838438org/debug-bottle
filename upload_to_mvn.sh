#!/bin/bash
upload() {
    rm settings.gradle
    cp settings.gradle.before settings.gradle
    ./gradlew clean assemble
    ./gradlew :core:uploadArchives
    ./gradlew :views:uploadArchives
    ./gradlew :blockcanary:uploadArchives
    ./gradlew :components:uploadArchives
    cleanGradleCache
    rm settings.gradle
    cp settings.gradle.ready settings.gradle
    ./gradlew clean
    ./gradlew :runtime:uploadArchives

    ./gradlew :noop-java:uploadArchives
    ./gradlew :noop-kotlin:uploadArchives
}
uploadExceptRuntime() {
    rm settings.gradle
    cp settings.gradle.before settings.gradle
    ./gradlew clean assemble
    ./gradlew :core:uploadArchives
    ./gradlew :views:uploadArchives
    ./gradlew :blockcanary:uploadArchives
    ./gradlew :components:uploadArchives
    ./gradlew :noop-java:uploadArchives
    ./gradlew :noop-kotlin:uploadArchives
}
uploadPrimary() {
    git checkout 1.0.1
    uploadExceptRuntime
}
upload101_23() {
    git checkout v23/1.0.1
    uploadExceptRuntime
}
upload101_22() {
    git checkout v22/1.0.1
    uploadExceptRuntime
}
cleanGradleCache() {
    rm -rf ~/.gradle/caches/modules-2/files-2.1/com.exyui.android
}
uploadPrimary
upload101_22
upload101_23
git checkout 1.0.1