allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let {
            // Safe casting for Android extension compile SDK
            try {
                val compileSdkMethod = it.javaClass.getMethod("compileSdk", Int::class.java)
                compileSdkMethod.invoke(it, 34) // Using stable SDK version 34 or 35 to avoid deprecation crash
            } catch (e: Exception) {
                // Fallback if method differs
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
