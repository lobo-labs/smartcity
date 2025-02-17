package br.com.lobolabs.smartcity

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform