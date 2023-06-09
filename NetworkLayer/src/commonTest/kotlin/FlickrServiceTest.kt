//import com.dimohamdy.flikerapplication.*
//import io.ktor.client.call.*
//import io.ktor.client.statement.*
//import org.mockito.kotlin.*
//import kotlinx.coroutines.runBlocking
//import org.junit.Assert.assertEquals
//import org.junit.Test
//import java.io.File
//
//class FlickrServiceTest {
//    private val mockHttpClient = mock<HttpClient>()
//    private val flickrService = FlickrService(mockHttpClient)
//
//    @Test
//    fun `test searchPhotos`() = runBlocking {
//        // Mocked data
//        val mockResponse = File("mock_response.json").readText()
//        val mockPhoto = Photo("1", "owner", "secret", "server", 1, "title", 1, 1, 1)
//        val expectedPhotos = listOf(mockPhoto)
//
//        // Mock the HTTP response
//        val mockHttpResponse = mock<HttpResponse>()
//        whenever(mockHttpResponse.status).thenReturn(HttpStatusCode.OK)
//        coWhenever(mockHttpResponse.readText()).thenReturn(mockResponse)
//
//        // Mock the HTTP client behavior
//        coWhenever(mockHttpClient.get<HttpResponse>(any())).thenReturn(mockHttpResponse)
//
//        // Perform the search
//        val query = "cat"
//        val page = 1
//        val photos = flickrService.searchPhotos(query, page)
//
//        // Assert the result
//        assertEquals(expectedPhotos, photos)
//    }
//}