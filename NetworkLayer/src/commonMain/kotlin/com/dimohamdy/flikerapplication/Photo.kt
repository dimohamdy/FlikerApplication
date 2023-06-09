package com.dimohamdy.flikerapplication
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Photo(
    val id: String,
    val owner: String,
    val secret: String,
    val server: String,
    val farm: Int,
    val title: String,
    @SerialName("ispublic")
    val isPublic: Int,
    @SerialName("isfriend")
    val isFriend: Int,
    @SerialName("isfamily")
    val isFamily: Int,
){
    val imagePath: String
        get() = "http://farm$farm.static.flickr.com/$server/${id}_$secret.jpg"
}

@Serializable
data class PhotosResponse(val photos: Photos)

@Serializable
data class Photos(val photo: List<Photo>)