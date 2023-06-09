package com.dimohamdy.flikerapplication

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform