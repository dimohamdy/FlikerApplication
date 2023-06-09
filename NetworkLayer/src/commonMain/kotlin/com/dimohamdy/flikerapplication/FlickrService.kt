package com.dimohamdy.flikerapplication

import io.ktor.client.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.serialization.json.Json
import io.ktor.client.call.*
import io.ktor.client.request.*
import io.ktor.client.statement.HttpResponse

class FlickrService {
    private val httpClient = HttpClient {
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
    }

    suspend fun searchPhotos(query: String, page: Int): List<Photo> {
        val url = "https://api.flickr.com/services/rest/"
        val parametersValues = listOf(
            "method" to "flickr.photos.search",
            "api_key" to "9cdaf7e6bec8e371ca6a2b7fa20781f6",
            "format" to "json",
            "nojsoncallback" to "1",
            "text" to query,
            "page" to page.toString()
        )

        val photosResponse: PhotosResponse = httpClient.get(url) {
            url {
                parametersValues.forEach { parameter ->
                    parameters.append(parameter.first, parameter.second)
                }
            }
        }.body()

        return photosResponse.photos.photo
    }
}
