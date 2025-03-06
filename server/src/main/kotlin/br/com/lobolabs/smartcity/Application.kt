package br.com.lobolabs.smartcity

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.http.content.default
import io.ktor.server.http.content.files
import io.ktor.server.http.content.static
import io.ktor.server.http.content.staticFiles
import io.ktor.server.netty.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.io.File

fun main(args: Array<String>): Unit = EngineMain.main(args)

fun Application.module() {
    routing {
        staticFiles(remotePath = "/", File("composeApp/build/dist/wasmJs/productionExecutable"))
        get("/health") {
            call.respondText("Ktor: ${Greeting().greet()}")
        }
    }
}